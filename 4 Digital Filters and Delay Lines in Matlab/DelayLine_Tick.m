function [delayLine,writePointer,readPointer,outputSample] = DelayLine_Tick(maxLength,delayLine,writePointer,readPointer,inputSample)
% ----------------------------------------------------------------------------------------------------------------------------
% [delayLine,writePointer,readPointer,outputSample] = DelayLine_Tick(maxLength,delayLine,writePointer,readPointer,inputSample)
% ----------------------------------------------------------------------------------------------------------------------------
%
% Function used to obtain an output sample from the delay line. 
% It will update read and write pointers as well as the delay line contents.
%
% INPUTS:
% 	- 	maxLength (integer): maximum length of the delay line
%	- 	delayLine (float vector): internal buffer
% 	-	writePointer (integer): current position of the write pointer
%	-   readPointer (integer): current position of the read pointer
%	- 	inputSample (float): input sample fed into the delay line
% OUTPUTS:
%	- 	delayLine (float vector): updated internal buffer
% 	-   writePointer (integer): updated position of the writePointer
%	- 	readPointer (integer): updated position of the readPointer
%	-   outputSample (float): output sample obtained by the delay line
% ------------------------------------------------------------------------- 


  outputSample = delayLine(readPointer); % read the readPointer value
  delayLine(writePointer) = inputSample; % set the value at the write pointer
  writePointer = mod(writePointer, maxLength) + 1; % tick writePointer to next value
  readPointer = mod(readPointer, maxLength) + 1; % tick readPointer to next value

end