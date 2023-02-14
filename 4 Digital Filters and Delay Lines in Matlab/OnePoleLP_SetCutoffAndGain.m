function [b0,a1] = OnePoleLP_SetCutoffAndGain(g,fc,fs)
% -------------------------------------------------------------------------
% [b0,a1] = OnePoleLP_SetCutoffAndGain(g,fc,fs)
% -------------------------------------------------------------------------
%
% Function used to set design the coefficients of a one-pole recursive
% IIR filter of the form
% 
%             b0
% H(z) = -------------
%        1 - a1 * z^-1
% 
% INPUTS:
% 	- 	g (float): gain of the filter at DC (i.e., at f = 0)
% 	-	fc (float): cut-off frequency of the filter in Hz
%	-	fs (float): sample rate of the filter
% OUTPUTS:
%	- 	b0 (float): numerator coefficient
%	- 	a1 (float): denominator coefficient
% ------------------------------------------------------------------------- 


% first design coefficient a1 to satisfy the cutoff frequency requirement
a1 = exp(-2 * pi * fc / fs);

% then design numerator coefficient to satisfy the gain at f=0 (i.e, at DC)
b0 = g * (1 - a1);

end