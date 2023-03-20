#include "SineWave.h"
#include "RtWvOut.h"
#include "ADSR.h"
#include <iostream>
#include <cstdlib>
#include <ctime>
#include <cmath>

using namespace stk;

/**
 * Program generate random pentatonic pitches at a specified note duration and time. 
*/
int main(int argc, char *argv[])
{
	float sampleRate = 44100.0;
	int numChannels = 1;

	SineWave sine; 
	ADSR envelope;
	RtWvOut dac(numChannels); // default realtime output device for one-channel playback

  	// Check command line arguments and provide usage instructions
	if (argc != 3) {
		std::cerr << "Usage: " << argv[0] << " <note duration> <total duration>" << std::endl;
		std::cout << "Example call: ./GeneratePentatonics 2 20" << std::endl;
		return 1;
  	}
	float noteDuration = std::atof(argv[1]);
	float totalDuration = std::atof(argv[2]);

	Stk::setSampleRate(sampleRate);
	std::srand(std::time(0)); // random number generator seed
	
	// Initialize ADSR 
    envelope.setAttackTime(noteDuration/4);
    envelope.setDecayTime(noteDuration/4);
    envelope.setSustainLevel(0.7);
    envelope.setReleaseTime(noteDuration/2);

	// Generating random pentatonic pitches and playing them
	float startTime = 0;
	while (startTime < totalDuration) {
		float frequency = 440.0 * pow(3.0/2.0, std::rand() % 5); // generating random pentatonic pitch
		sine.setFrequency(frequency);

		// Trigger the ADSR envelope
		envelope.keyOn();

		// Play the note
		float endTime = startTime + noteDuration;
		for (int i = 0; i < (int)(noteDuration * Stk::sampleRate()); i++) {
			float sample = envelope.tick() * sine.tick();
			dac.tick(sample);
		}

		// Release the ADSR envelope
		envelope.keyOff();

		startTime = endTime; 
	}

	return 0;
}
