function [out1,out2] = morletbb(varargin)

% Morlet wavelet.
%   varargin=[LB UB N]
%   [out1,out2] = morletbb(varargin) returns values of 
%   the Morlet wavelet on a N points regular grid 
%   on the interval [LB,UB].
%   Output arguments are the wavelet function out1
%   computed on the grid out2 of time.
%   This wavelet has [-4 4] as effective support with N=1024 points.
%   We choose this wavelet type (Morlet) because it allow to mimimise 
%   the value of product Dt*DF (variation for time and frequence).
%   It constitue the best compromise betewen a good time and frequential 
%   resolution 

%if errargn(mfilename,nargin,[3 4],nargout,[0:2])
   
%   error('*'); 

%end

% Compute values of the Morlet wavelet.
% d is a constante which allow to chose the resolution
% When d tend towards 0, the time resolution becomes very 
% good and the frequencial resolution is bad
% If d takes large values it's contrary and and the wavelet  
% becomes a Fourrier transform
% In pratic d=[1 2]. We take d=1 in your case
% The admissibilite condition for this wavelet is (2*pi*d^2>5)
d=1; 
out2 = linspace(varargin{1:3});        % wavelet support.
out1 = exp(-(out2.^2)/(2*d^2)+i*2*pi*out2);
 
