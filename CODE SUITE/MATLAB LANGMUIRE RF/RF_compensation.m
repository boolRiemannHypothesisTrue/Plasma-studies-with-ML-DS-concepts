function [Ne,Ni,Vp,Vf,Te,E,f]=RF_compensation(V,I,Area,Mi,N)
Number_of_harmonics_to_remove=N
close all

% This software perfoms RF compensation on raw Langmuir probe computer
% acquired data
%input arguments
%V is the probe voltage raw data as acquired by data acquisition device
%I is the probe current raw data as acquired by data acquisition device
% Define basic physical constants
e=1.6*10^-19;
m=9.1*10^-31;
kB=1.3806503*10^-23;
% Seperate Data points when probe voltage is increasing from those when
% voltage is decreasing. Only voltage increasing data points are used. This
% is to elimiate data points affected by probe plasma sheet collapse
[V,I]=separate(V,I);
% Sort data in incresing voltage values
[V,I]=treat(V,I);
 figure('color','white')
 % Plor raw data
plot(V,I,'.r')
hold
% Find and plot data after removal of first second and third harmonic
% contamination to the left side
% First harmonic
[V1L,I1L]=maxima(V,I);
[V1R,I1R]=minima(V,I);
plot(V1R,I1R,'db')
plot(V1L,I1L,'db')
%second harmonic
if N==1
   
    V3L=V1L;
    I3L=I1L;
    V3R=V1R;
    I3R=I1R
else
[V2L,I2L]=maxima(V1L,I1L);
[V2R,I2R]=minima(V1R,I1R);
plot(V2R,I2R,'ok')
plot(V2L,I2L,'ok')
if N==2
    
    V3L=V1L;
    I3L=I1L;
    V3R=V1R;
    I3R=I1R
else
%Third harmonic
if N==3
[V3L,I3L]=maxima(V2L,I2L);
[V3R,I3R]=minima(V2R,I2R);
plot(V3R,I3R,'k')
plot(V3L,I3L,'k')

xlabel('Probe Voltage (Volts)')
ylabel('Probe Current (Amperes)')
end
end
end
% Correct number of data poinst
[VVL,VVR]=match(V3L,V3R);
[IIL,IIR]=match(I3L,I3R);
% Calculate the rquired shift to get the correct IV
K1=find(IIL>max(IIL/2));
K1=min(K1);
K2=find(IIR>max(IIR/2));
K2=min(K2);
DV=VVL(K1)-VVR(K2);
VVL=VVL-DV/2;
VVR=VVR+DV/2;
v=VVL;
i=IIL;
% Perform the final analysis and get plasma parameters
[Ne,Ni,Vp,Vf,Te,E,f]=Analyze_Langmuir(v,i,Area,Mi);


