%% File Reading
clear; clc;
RESULT = readmatrix('20000101_042035.csv');
t = RESULT(:,1);  
U1 = RESULT(:,2)*(10^-3); % mV to V
U2 = RESULT(:,3)*(10^-3); % mV to V

%% Experimental Parameters
R = 130; % Ohms
r = 0.25*10^(-3); % Probe radius in meters
h = 6*10^(-3); % Probe length in meters
S = 2*pi*r*(r+h); % Probe area in square meters
mi = 6.64*10^(-27); % Ion mass (gas)

%% Plotting Input Data
figure;
plot(t, U1, t, U2)
ylabel('U, V')
xlabel('t, µs')

%% VAH
diap = (340:745); % Range of points for VAH
y = U1(diap,1) - U2(diap,1);
I = y / R;
U = U1(diap,1);
figure;
plot(U, I);
xlabel('U, V')
ylabel('I, A')
grid on

%% Filter
figure
rd = 1;
fl = 15;
If = sgolayfilt(I, rd, fl);
subplot(2,1,1)
plot(U, I)
title('Original')
grid on
subplot(2,1,2)
plot(U, If)
title('Filtered')
grid on

%% I-Is=Ie
Is = 0.0065; % Saturation ion current from VAH
Ie = I + Is;
Ief = If + Is;
figure;
subplot(2,1,1)
plot(U, Ie);
xlabel('U, V')
ylabel('Ie, A')
grid on
subplot(2,1,2)
plot(U, Ief);
xlabel('U, V')
ylabel('Ie, A')
grid on

%% Up VAH Plasma Potential Determination
figure;
semilogy(U, Ief)
xlabel('U, V')
ylabel('Log(Ie), A')

%% Ranges for Approximation Lines
diap1 = (236:406); % Range of points for approximation 1
b1 = -10:1:100; % Range for building approximation line 1
diap2 = (150:161); % Range of points for approximation 2 
b2 = -20:0.1:20; % Range for building approximation line 2
diap3 = (16:27); % Range of points for approximation 3
b3 = -60:0.1:-40; % Range for building approximation line 3

%% Approximation Line 1
hold on
ft = fittype('exp(x*b)*c');
coeffnames(ft);
b = U(diap1,1);
a = Ie(diap1,1);
f1 = fit(b, a, ft, 'StartPoint', [0.1, 1]); 
coeff1 = coeffvalues(f1);
a1 = coeff1(1,2) * exp(coeff1(1,1) * b1);
semilogy(b1, a1)

%% Approximation Line 2
hold on
ft = fittype('exp(x*b)*c');
coeffnames(ft); 
b = U(diap2,1);
a = Ie(diap2,1);
f2 = fit(b, a, ft, 'StartPoint', [0.1, 1]);
coeff2 = coeffvalues(f2);
a2 = coeff2(1,2) * exp(coeff2(1,1) * b2);
Tevah = 1 / coeff2(1,1);
semilogy(b2, a2)
txt = ['Te = ' , num2str(Tevah), ' eV'];
text(40, 10^-3, txt)

txt = ['Vp = ' , num2str(10.1), ' V'];
text(40, 2*10^-3, txt)
txt = ['n = ' , num2str(5.4576e+17), ' m^-^3'];
text(40, 6*10^-4, txt)

%% Approximation Line 3
ft = fittype('exp(x*b)*c');
coeffnames(ft);
b = U(diap3,1);
a = Ie(diap3,1);
f3 = fit(b, a, ft, 'StartPoint', [0.1, 0.1]);
coeff3 = coeffvalues(f3);
a3 = coeff3(1,2) * exp(coeff3(1,1) * b3);
Tehot = 1 / coeff3(1,1);
semilogy(b3, a3)

%% Te & n
Uf = -12; % Floating potential
Up = 10.6; % Plasma potential
Te = (Up - Uf) / 3;
n = Is / (S * 0.61 * 1.6 * 10^(-19) * sqrt(1.6 * 10^(-19) * Tevah / mi));

%% First Derivative
y1 = diff(If);
figure
rd = 1;
fl = 55;
Ief1 = sgolayfilt(y1, rd, fl);
subplot(2,1,1)
plot(U(1:(length(U)-1),1), y1)
title('Original')
grid
subplot(2,1,2)
plot(U(1:(length(U)-1),1), Ief1)
title('Filtered')
grid on

%% Second Derivative
y2 = diff(Ief1);
figure
rd = 1;
fl = 75;
Ief2 = sgolayfilt(y2, rd, fl);
subplot(2,1,1)
plot(U(1:(length(U)-2),1), y2)
title('Original')
grid
subplot(2,1,2)
plot(U(1:(length(U)-2),1), Ief2)
title('Filtered')
grid on

%% EEDF Calculation
e = 1.6*10^(-19);
me = 9.1*10^(-31);
Uz = -8.75 + U2(diap);
E1 = Uz;
i = 1:1:(length(Uz)-2);
f = (4/((1.6*10^(-19))^2*S)) * sqrt((9.1*10^(-31).*E1(i,1)) / (2*(1.6*10^(-19)))) .* Ief2(i,1);
flog = log(f);
f1 = (2*sqrt(e.*E1(i,1))*sqrt(2*me).*Ief2(i,1)) / e^3*S;
f2 = ((2*me) / (S*e^2)) * sqrt((2.*E1(i,1)) / me) .* Ief2(i,1);
figure
plot(E1(1:(length(Uz)-2),1), -f, 'o')
xlabel('E, eV')
ylabel('EEDF')
ylim([0 inf])
xlim([0 inf])

figure
semilogy(E1(1:(length(Uz)-2),1), -f, 'o')
xlabel('E, eV')
ylabel('EEDF')

