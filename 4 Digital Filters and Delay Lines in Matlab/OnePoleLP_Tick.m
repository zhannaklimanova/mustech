function [s1,output] = OnePoleLP_Tick(b0,a1,s1,input)
% ---------------------------------------------
% [s1,output] = OnePoleLP_Tick(b0,a1,s1,input);
% ---------------------------------------------
%
% Performs one tick of a one-pole recursive
% IIR filter of the form
% 
%             b0
% H[z] = -------------
%        1 - a1 * z^-1
%
% It will also return the (single) state variable of the filter, ot be used
% in the next call to 'tick'.
%
% INPUTS:
%   - 	b0 (float): numerator coefficient
%	- 	a1 (float): denominator coefficient
% 	-	s1 (float): the ( sole ) state variable of the filter (the previous output)
%	-   input (float): the input sample
% OUTPUTS:
%   -   s1 (float): the updated state variable of the filter, to be used in
%       the next call to 'tick'
%	- 	output (float): the output sample
% ------------------------------------------------------------------------- 

output = b0 * input + a1 * s1; % perform calculation of output

s1 = output; % update the state variable(s)
             % > in this case it's just one so it looks stupid, but in a
             % filter with a1 and a2 coefficients (and therefore two output
             % state variables s1 and s2), we would need to do something
             % like:
             % s2 = s1;
             % s1 = output;

end