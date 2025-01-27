function [Ne,Ni,Vp,Vf,Te,E,f]=Analyze_Langmuir(V,I,Area,Mass)
[M1,N1]=size(V);
if M1>N1
    V=V';
end
[M2,N2]=size(I);
if M2>N2
    I=I';
end
% Define bacic physical constants needed
e=1.6*10^-19;
m=9.1*10^-31;
kB=1.3806503*10^-23;
Mi=Mass*1.660538921*10^-27;
figure('color','white')
% plot inputted data
plot(V,I,'.k')
%Normalize the data (This is for better fit accrucy)
H=max(I);
%define fitting parameters starting values
H=max(I);
% Perform fit
a=[1 -5 5 0];
for jj=1:100;
[a,rr]=nlinfit(V,I/H,'langmuir',a);
if (mean(rr.^2))^.5 <.05*(max(I/H));
  
break 
end
(mean(rr.^2))^.5
end
% calculate ion  and electron saturation current
Iion=H*langmuir(a,2*min(V));
Ies=H*langmuir(a,3*max(V));
% calculate and plot fitted I-V
V=min(V):.1:max(V);
z=H*langmuir(a,V);
hold
plot(V,z,'r')
xlabel('Probe Voltage (Volts)')
ylabel('Probe current (Amperes)')
legend('data','fit')
input('Is the fit OK Press enter for YES. If NO, Press Cotrol C change value of a(2), and a(3) in line 24 and start again')
%calculate Plasma potential Vp
Vp=a(3)*atanh((((1+a(1)^2)^.5)-1)/a(1))-a(2);
VV=2*min(V):.1:3*max(V);
% Calculate Flouting Potential Vf
Z=H*langmuir(a,VV);
k=find(Z>=0);
k=min(k);
Vf=VV(k);
% find first and second derivatives and plot second derivative
d1f=diff(Z)./diff(VV);
VV(1)=[];
d1f=d1f;
d2f=diff(d1f)./diff(VV);
VV(1)=[];
figure ('color','white')
plot(VV,d2f);
grid on 
xlabel('Probe Voltage (Volts)')
ylabel('Second Derivative (Ampere/Volt^2)')
% Calculate and plot electron energy distribution function
k=find(VV)<=Vp;
t=Vp:.1:3*max(VV);
xx=abs(t.^(1/2));
ff=diff(diff(langmuir(a,t)));
ff=[ff 0 0];
f=-xx.*ff;
E=t-Vp;
T=(2/3)*trapz(E,E.*f)/trapz(t,f);
k=find(E>70);
E(k)=[];
f(k)=[];
figure('color','white')
plot(E,f,'k');
% Fit EEDF to maxwell-Boltzman Distribution law
a=[.00001 .1];
a=nlinfit(E,f,'maxwell',a);
fm=maxwell(a,E);
% Fit EEDF to Druyvesteyn distribution Law
b=[1 .01];
b=nlinfit(E,f,'Dry',b);
fd=Dry(b,E);
hold
plot(E,fm,'r')
plot(E,fd)
KK=trapz(E,f);
xlabel('Electron Enery (eV)')
ylabel('EEDF (M^-3 eV^-1)')
legend('Data','Maxwell','Druyvesteyn')
Ne=KK*((8*m)^.5)/(Area*e^1.5);
% Show final results
Ni=(abs(Iion)/(0.52*Area*e^1.5))*(Mi/T)^.5;
Iis=Iion
Ies
Ne
Ni
Te=T
Vp
Vf