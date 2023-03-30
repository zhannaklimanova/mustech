// #include "ADSR.h"
// #include "SineWave.h"
// #include "RtWvOut.h"
// #include <Asymp.h>
// #include <cmath>

// using namespace stk;

// /**
//  * Program generates a clarinet like sound with the FM clarinet algorithm.
// */
// int main(int argc, char* argv[])
// {
//     // Optional input arguments for resulting sound
//     float fc = (argc > 1) ? std::stof(argv[1]) : 900.0;  // fundamental frequency
//     float DUR = (argc > 2) ? std::stof(argv[2]) : 0.5;   // duration (DUR) in seconds

//     ADSR F1;
//     Asymp F2;
//     SineWave carrier;
//     SineWave modulator;
//     RtWvOut output;
//     float sampleRate = 44100.0;
//     float fm = (3.0/2.0)*fc;
//     int numChannels = 1;
//     float IMIN = 2.0;
//     float IMAX = 4.0;

//     Stk::setSampleRate(sampleRate);

//     // Initialize ADSR (approximation to the asymptotic version of the adsr)
//     F1.setAttackTime(0.02 * DUR);
//     F1.setDecayTime(0.01 * DUR);
//     F1.setSustainLevel(0.6);
//     F1.setReleaseTime(0.4 * DUR);
//     F1.keyOn();

//     // Initialize the Asymp
//     F2.setTime(DUR);
//     F2.setTarget(0.0);
//     F2.keyOn();

//     // Initialize the carrier and modulator waveforms (multiplied by 2 to shift up by one octave)
//     carrier.setFrequency(2*fc);
//     modulator.setFrequency(2*fm); // where [fc : fm ratio of 3 : 2] (e.g. fc=900 and fm=600)

//     // One-channel realtime output object 
//     output.start();

//     float modulatorOutput = 0.0;
//     float maxD = fm * (IMAX-IMIN); 
//     long counter = 0;
//     long releaseCount = (long) (Stk::sampleRate() * 0.4 * DUR);
//     while (F1.getState() != ADSR::IDLE && (counter < Stk::sampleRate() * DUR)) {
//         modulatorOutput = (IMIN * fm) + (modulator.tick() * (F2.lastOut() * maxD));
//         carrier.setFrequency(fc + modulatorOutput);

//         // Write the output sample to the buffer.
//         output.tick(F1.lastOut() * carrier.tick());
        
//         // Update the counter and check for release time.
//         F1.tick();
//         F2.tick();
//         if (counter++ >= releaseCount) {
//             F1.keyOff();
//             F2.setTarget(1.0);
//         }
//     }

//     return 0;
// }

#include "ADSR.h"
#include "SineWave.h"
#include "RtWvOut.h"
#include <Asymp.h>
#include <cmath>

using namespace stk;

/**
 * Program generates a clarinet like sound with the FM clarinet algorithm.
*/
int main(int argc, char* argv[])
{
    // Optional input arguments for resulting sound
    float f0 = (argc > 1) ? std::stof(argv[1]) : 440.0;  // fundamental frequency
    float DUR = (argc > 2) ? std::stof(argv[2]) : 0.5;   // duration (DUR) in seconds
    float fc = 3 * f0;
    Asymp F1;
    Asymp F2;
    SineWave carrier;
    SineWave modulator;
    RtWvOut output;
    float sampleRate = 44100.0;
    float fm = 2 * f0;
    int numChannels = 1;
    float IMIN = 2.0;
    float IMAX = 4.0;

    Stk::setSampleRate(sampleRate);

    // Initialize ADSR (approximation to the asymptotic version of the adsr)
    // F1.setAttackTime(0.2 * DUR);
    // F1.setDecayTime(0.01 * DUR);
    // F1.setSustainLevel(1);
    // F1.setReleaseTime(0.2 * DUR);
    F1.setTime(0.3 * DUR);
    F1.keyOn();

    // Initialize the Asymp
    F2.setTime(DUR);
    F2.setTarget(0.0);
    F2.keyOn();

    // Initialize the carrier and modulator waveforms (multiplied by 2 to shift up by one octave)
    carrier.setFrequency(fc);
    modulator.setFrequency(fm); // where [fc : fm ratio of 3 : 2] (e.g. fc=900 and fm=600)

    // One-channel realtime output object 
    output.start();

    float modulatorOutput = 0.0;
    float maxD = fm * (IMAX-IMIN); 
    long counter = 0;
    long releaseCount = (long) (Stk::sampleRate() * (DUR - 0.9));
    while (F1.getState() != ADSR::IDLE && (counter < Stk::sampleRate() * DUR)) {
        modulatorOutput = (IMIN * fm + F2.lastOut() * maxD) * (modulator.lastOut());
        carrier.setFrequency(fc + modulatorOutput);

        // Write the output sample to the buffer.
        output.tick(F1.lastOut() * carrier.tick());
        
        // Update the counter and check for release time.
        F1.tick();
        F2.tick();
        modulator.tick(); // same as modulator.tick() in lilne 128 but then you'd haave to remove the modulator.lastOut() 
        if (counter++ == releaseCount) {
            F1.setTime(0.9);
            F1.keyOff();
            // F2.setTarget(1.0);
        }
    }

    return 0;
}
