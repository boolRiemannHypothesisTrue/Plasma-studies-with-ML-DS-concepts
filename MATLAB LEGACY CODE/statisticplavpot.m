%% Считывание файла
clear; clc;
RESULT= readmatrix('20000101_003056.csv');
t= RESULT(:,1);  
U1= RESULT(:,2)*(10^-3); %mV 
U2=RESULT(:,3)*(10^-3);  %mV
RESULT1= readmatrix('20000101_002222');
t1= RESULT1(:,1);  
U11= RESULT1(:,2)*(10^-3); %mV 
RESULT2= readmatrix('20000101_002639');
t2= RESULT2(:,1);  
U12= RESULT2(:,2)*(10^-3); %mV 
%% Графический вывод входных данных
 figure
 plot(t(1:1000,1),U1(1:1000,1))
 ylabel('U_f, В')
 xlabel('Количество измеренных точек')
 legend('Плавающий потенциал 0.1 мкс ')
  figure
  plot(t1(1:1000,1),U11(1:1000,1))
 ylabel('U_f, В')
 xlabel('Количество измеренных точек')
 legend('Плавающий потенциал 1 мкс')
  figure
  plot(t2(1:1000,1),U12(1:1000,1))
 ylabel('U_f, В')
 xlabel('Количество измеренных точек')
 legend('Плавающий потенциал 10 мкс ')
%  figure
%  plot(t(1:100,1),U2(1:100,1))
%  ylabel('U_f, В')
%  xlabel('\tau, мкс')
%  figure
%  plot(t,U1,t,U2)
%  ylabel('U_f, В')
%  xlabel('\tau, мкс')
 %% Графический вывод входных данных
 figure
 plot(t,U1)
 ylabel('U_f, V')
 xlabel('t, µs')
%  hold on
%  plot(t,U2)
%  ylabel('U_f, V')
%  xlabel('t, µs')
 %%
 SumU1 = sum(U1)/length(U1);
 txt1=[num2str(SumU1)]
  %%
 SumU2 = sum(U2)/length(U2);
 txt1=[num2str(SumU2)]
%% статистика Uf по 1 зонду
figure 
h = histfit(U1,101,'normal')
hold on
h = histfit(U11,110,'normal')
h = histfit(U12,110,'normal')
legend('Плавающий потенциал 0.1 мкс','Распределение Гаусса 0.1 мкс'  ,...
    'Плавающий потенциал 1 мкс','Распределение Гаусса 1 мкс' ,...
    'Плавающий потенциал 10 мкс','Распределение Гаусса 10 мкс' )
ylabel('Количество значений')
xlabel('U_f, В')
%% статистика Uf по 2 зонду
figure 
hist = histogram(U1);
ylabel('Количество значений')
xlabel('U_f, В')
Nbins = morebins(hist)
hist.NumBins = 110;
y = skewness(U1); %асимметрия
n = kurtosis(U1); %  эксцесс
h = awc_hurst(U1); 
txt2zond1 = ['Коэффициент асимметрии=',num2str(y)]
txt2zond2 = ['Коэффициент эксцесса=' ,num2str(n)]
txt2zond3 = ['Показатель Хёрста=' ,num2str(h)]
%% Фурье спектр 1 
s = U1';
Ts= 0.1*10^(-6);
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
%% Фурье спектр 2
s = U2';
Ts = 0.1*10^(-6);
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
rd = 1;
fl = 15;
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
loglog(fshift(1,50110:65000),sffilt(1,50110:65000))
grid on
xlabel('f, Гц')
ylabel('S(f)')
 %% Фурье спектр ампроксимирующая прямая
 hold on
ft = fittype('c*x^(-a)');
coeffnames(ft);
 b=fshift(1,53010:61000)';
 a=abs(yshift(1,53010:61000))';
fsf = fit(b,a,ft,'StartPoint',[1,1]) 
coeffsf = coeffvalues(fsf);
 b=fshift(1,53010:61000);
 a=coeffsf(1,2)*185*b.^-(1.4);
  lg = loglog(b,a,'k');
 lg(1).LineWidth = 1.5;
xt = [490400 ];
 yt = [60];
 s = num2str(coeffsf(1,1));
  text(xt,yt,['~f^-^1^.^4 '],'FontSize',15);
% xt = [42040 ];
%  yt = [10];
%   text(xt,yt,'~f ^-^1^.^2^1','FontSize',14)
 %% Фурье спектр ампроксимирующая прямая
  hold on
 b=fshift(1,54510:70000);
 a=4.812e+08*b.^-(1.156);
 loglog(b,a);
 
% xt = [42040 ];
%  yt = [10];
%   text(xt,yt,'~f ^-^1^.^2^1','FontSize',14)
%%
x=U1(1:100000,1);
% 
 GK=x;
 da=0.01;
 dk=30;
figure
subplot(311); plot(GK); grid; 
subplot(312); c1=cwt(GK,1:da:dk, 'morl','abslvl',[100 1000]);
subplot(313); c1=cwt(GK,1:da:dk, 'mexh','abslvl',[100 1000]);
%   subplot(312); c1=cwt(GK,1:da:dk, 'morl','abslvl');
  %%
  x = [55 45 35 25 15 5 0 -5 -15 -25 -35 -45 -55];
y = [-1.3109
-1.4546
-1.4535
-2.2143
-4.9951
-4.4208
-4.5172
-4.9431
-5.9357
-3.0809
-0.59553
-0.52229
-0.085232
];
y1 = [-1.4658
-1.5552
-1.5938
-2.5502
-5.094
-4.3257
-4.3537
-4.6432
-5.7447
-3.0282
-0.51879
-0.34264
0.073964
]
y2 = [-1.3381
-1.4858
-1.4632
-2.3826
-5.0953
-4.2434
-3.9609
-4.4938
-5.374
-2.3813
-0.065587
-0.035598
0.23169
]
plot(x,y,'o')
hold on
plot(x,y1,'.','MarkerSize',20)
plot(x,y2,'*','MarkerSize',10)
grid on
xticks([-55 -45 -35 -25 -15 -5 5 15 25 35 45 55])
xlim([-55 55])
ylabel('U_f, В')
xlabel('R, мм')
legend('Плавающий потенциал 0.1 мкс ','Плавающий потенциал 1 мкс ','Плавающий потенциал 10 мкс ')

%% KA
x = [-55 -45 -35 -25 -15 -5 0 5 15 25 35 45 55];
y = [-0.23254
-0.13546
-0.21703
-0.097608
0.0059429
-0.034344
-0.051529
-0.029727
0.044997
-0.033192
-0.11879
-0.10589
-0.12326
];
y1 = [-0.18935
-0.13546
-0.17303
-0.070953
0.0093699
-0.04044
-0.043296
-0.048237
0.019496
-0.037674
-0.12377
-0.11778
-0.12928
]
plot(x,y,'o')
hold on
plot(x,y1,'.','MarkerSize',20)
grid on
xticks([-55 -45 -35 -25 -15 -5 5 15 25 35 45 55])
xlim([-55 55])
ylim([-1 1])
ylabel('Коэффициент асимметрии')
xlabel('R, мм')
%% KE
x = [-55 -45 -35 -25 -15 -5 0 5 15 25 35 45 55];
y = [3.4233
3.289
3.3359
3.2721
3.0635
3.2435
3.167
3.1816
3.0376
2.9711
3.3417
3.2546
3.2757
];
y1 = [3.3963
3.289
3.3114
3.2783
3.0614
3.3458
3.3016
3.182
3.083
3.005
3.4097
3.3413
3.3141
]
plot(x,y,'o')
hold on
plot(x,y1,'.','MarkerSize',20)
grid on
xticks([-55 -45 -35 -25 -15 -5 5 15 25 35 45 55])
xlim([-55 55])
ylim([2 4])
ylabel('Коэффициент эксцесса')
xlabel('R, мм')
%% H
x = [55 45 35 25 15 5 0 -5 -15 -25 -35 -45 -55];
y = [0.68863
0.63252
0.65739
0.72722
0.69837
0.58155
0.5874
0.62458
0.64105
0.69904
0.69435
0.68724
0.66637
];
y1 = [0.67455
0.60919
0.65656
0.72257
0.69926
0.61333
0.5859
0.6237
0.60865
0.68648
0.68133
0.67172
0.68522
];
y2 =[0.65979
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
0.67992
];
y3 =[0.65055
0.62961
0.64017
0.6379
0.5454
0.53479
0.56355
0.57695
0.51108
0.52333
0.62064
0.61831
0.62513
];
y4= [0.65613
0.6361
0.61293
0.61574
0.56401
0.61837
0.64799
0.62828
0.60776
0.57629
0.64473
0.62462
0.64839];
figure
plot(x,y,'o')
hold on
plot(x,y2,'.','MarkerSize',20)
plot(x,y4,'*','MarkerSize',10)
grid on
xticks([-55 -45 -35 -25 -15 -5 5 15 25 35 45 55])
xlim([-55 55])
ylim([0.5 1])
legend('Плавающий потенциал 0.1 мкс ','Плавающий потенциал 1 мкс ','Плавающий потенциал 10 мкс ')
ylabel('H')
xlabel('R, мм')
%%
Hoelderf_2007(U1(1:100000,1))