%% Считывание файла
clear; clc;
RESULT= readmatrix('20000101_011618');
t= RESULT(:,1);  
U1= RESULT(:,2)*(10^-3); %mV 
U2=RESULT(:,3)*(10^-3);  %mV
%% 
R = 200; %сопротивление Ом
% %% Графический вывод входных данных
%  figure(1)
%  plot(t,U1)
%  ylabel('U_f, V')
%  xlabel('\tau, µs')
%  figure
%  plot(t,U2)
%  ylabel('U_f, V')
%  xlabel('\tau, µs')
%  %% Графический вывод входных данных
%  figure
%  plot(t,U1)
%  ylabel('U_f, V')
%  xlabel('t, µs')
%  hold on
%  plot(t,U2)
%  ylabel('U_f, V')
%  xlabel('t, µs')
 %% ion tok nas
y2=U1-U2;
I=y2/R;
figure
plot(t,I);
ylabel('Ионный ток насыщения, А')
xlabel('\tau, мкс')
figure
plot(t(1:1000,1),I(1:1000,1))
ylabel('Ионный ток насыщения, А')
xlabel('\tau, мкс')
%%
figure
% plot(t(448:453,1),I(448:453,1))
% hold on
figure
plot(t(880:900,1),I(880:900,1))
ylabel('Ионный ток насыщения, А')
xlabel('\tau, мкс')
%% filter
figure
rd = 4;
fl = 45;
sf = I(1:500,1);
sffilt = sgolayfilt(sf,rd,fl);
subplot(2,1,1)
plot(t(1:500,1),I(1:500,1))
title('Оригинальный сигнал')
grid on
subplot(2,1,2)
plot(t(1:500,1),sffilt)
title('Фильтрованный сигнал')
grid on
 %%
 SumI = sum(I)/length(I);
 txt1=['Is =',num2str(SumI)]
%%  статистика Ii
figure 
clc; 
hist = histogram(I)
ylabel('Количество значений')
xlabel('Ионный ток насыщения, A')
Nbins = morebins(hist)
hist.NumBins = 115;
%%
figure 
clc; 
hist = histogram(I)
ylabel('Количество значений')
xlabel('Ионный ток насыщения, A')
Nbins = morebins(hist)
hist.NumBins = 115;
hold on
%% 
h = histfit(I,117,'normal')
ylabel('Количество значений')
xlabel('Ионный ток насыщения, A')
legend('Ионный ток насыщения','Распределение Гаусса')
%%  статистика Ii
y = skewness(I); %асимметрия
n = kurtosis(I); %  эксцесс
h = awc_hurst(I);
H = wfbmesti(I)
H1 = genhurst(I)
txt2=['Коэффициент асимметрии=',num2str(y)]
txt3=['Коэффициент эксцесса=' ,num2str(n)]
txt4=['Показатель Хёрста=' ,num2str(h)]
% text(-0.0065,3800,txt1)
% text(-0.0065,3600,txt2)
% text(-0.0065,3400,txt3)
% xlim([-0.014 0.0035])
%% Фурье спектр 2
s1 = U1- U2;
s =I';
Ts=1*10^(-6);
y = fft(s);   
Fs = 1/Ts;
figure
n = length(s);                         
fshift = (-n/2:n/2-1)*(Fs/n);
yshift = fftshift(y);
z=abs(yshift);
loglog(fshift,abs(yshift))
xlabel('f, Гц')
ylabel('S(f)')
%% filter
figure
rd = 10;
fl = 55;
sf = abs(yshift);
sffilt = sgolayfilt(sf,rd,fl);
subplot(2,1,1)
loglog(fshift,sf)
title('Оригинальный сигнал')
grid on
subplot(2,1,2)
loglog(fshift,sffilt)
title('Фильтрованный сигнал')
grid on
%% 
figure
loglog(fshift(1,50005:100000),sffilt(1,50005:100000))
title('Фильтрованный сигнал')
grid on
%%
clc;
 hold on
ft = fittype('c*x^(-a)');
coeffnames(ft);
 b=fshift(1,50002:100000)';
 a=abs(yshift(1,50002:100000))';
fsf = fit(b,a,ft,'StartPoint',[1,1]) 
coeffsf = coeffvalues(fsf);
 b=fshift(1,50002:80000);
 a=100*b.^(- 0.6);
 loglog(b,a);
%% Is
x = [-55 -45 -35 -25 -15 -5 0 5 15 25 35 45 55];
y = [0.0011407 0.001716 0.0023669 0.0036357 0.0063135 0.0070811 0.0067192 0.0062105 0.0039228 0.0012451 0.00091718 0.00093466 0.00057398];
plot(x,y, 'o')
grid on
xticks([-55 -45 -35 -25 -15 -5 5 15 25 35 45 55])
xlim([-55 55])
ylabel('I_s, А')
xlabel('R, мм')
%% KA
x = [-55 -45 -35 -25 -15 -5 0 5 15 25 35 45 55];
y = [0.085992 -0.011276 0.011884 -0.016897 0.070586 -0.0076172 -0.0010669 0.039465 0.017216 0.022814 0.056495 -0.0081756 -0.0067078];
plot(x,y, 'o')
grid on
xticks([-55 -45 -35 -25 -15 -5 5 15 25 35 45 55])
xlim([-55 55])
ylabel('Коэффициент асимметрии')
xlabel('R, мм')
%% KE
x = [-55 -45 -35 -25 -15 -5 0 5 15 25 35 45 55];
y = [4.7357 5.8099 5.5388 5.8386 5.878 5.982 5.8644 5.862 6.1571 6.1926 6.2381 6.2386 6.1649];
plot(x,y, 'o')
grid on
xticks([-55 -45 -35 -25 -15 -5 5 15 25 35 45 55])
xlim([-55 55])
ylabel('Коэффициент эксцесса')
xlabel('R, мм')
%% H
x = [-55 -45 -35 -25 -15 -5 0 5 15 25 35 45 55];
y = [0.80738
0.76677
0.74533
0.80628
0.79066
0.77667
0.77176
0.77516
0.77036
0.74725
0.80151
0.71016
0.7907];
y1 = [0.65979
0.64691
0.64149
0.62467
0.5466
0.56895
0.51656
0.59908
0.56134
0.54314
0.60345
0.65166
0.67992];
figure
plot(x,y,'o')
hold on
% plot(x,y1,'.','MarkerSize',20)
grid on
xticks([-55 -45 -35 -25 -15 -5 5 15 25 35 45 55])
xlim([-55 55])
ylim([0.5 0.9])
legend('Ионный ток насыщения','Плавающий потенциал')
ylabel('H')
xlabel('R, мм')
%% 
x = [-55 -45 -35 -25 -15 -5 0 5 15 25 35 45 55];
r=0.25*10^(-3); %Радиус зонда м
h=6*10^(-3); %Длина зонды м
S = 2*pi*r*(r+h); %Площадь зонда м^2
mi=6.64*10^(-27); %Масса иона(газ)
Is = [0.0011407
0.001716
0.0023669
0.0036357
0.0063135
0.0070811
0.0067192
0.0062105
0.0039228
0.0012451
0.00091718
0.00093466
0.00057398];
Tevah = 1;
n = Is/(S*0.61*1.6*10^(-19)*sqrt(1.6*10^(-19)*Tevah/mi));
figure
plot(x,n,'.','MarkerSize',20)
grid on
xticks([-55 -45 -35 -25 -15 -5 5 15 25 35 45 55])
xlim([-55 55])
ylabel('n_e, cm^-^3')
xlabel('R, mm')
%%
x=I(1:3000,1);
% 
 GK=x;
 da=0.001;
 dk=30;
 figure
subplot(311); plot(GK); grid; 
subplot(312); c1=cwt(GK,1:da:dk, 'morl','abslvl',[300 1000]);
subplot(313); c1=cwt(GK,1:da:dk, 'haar','abslvl',[300 1000]);
% subplot(312); c1=cwt(GK,1:da:dk, 'morl','abslvl');