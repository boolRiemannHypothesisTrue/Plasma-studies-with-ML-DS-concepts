clear; clc;
RESULT= readmatrix('20000101_002746.csv');
t(:,1)= RESULT(:,1);  
U1(:,1)= RESULT(:,2)*(10^-3); %mV 
U2(:,1)= RESULT(:,3)*(10^-3); %mV 
RESULT= readmatrix('20000101_002817.csv');
t(:,2)= RESULT(:,1);  
U1(:,2)= RESULT(:,2)*(10^-3); %mV 
U2(:,2)= RESULT(:,3)*(10^-3); %mV 
RESULT= readmatrix('20000101_002846.csv');
t(:,3)= RESULT(:,1);  
U1(:,3)= RESULT(:,2)*(10^-3); %mV 
U2(:,3)= RESULT(:,3)*(10^-3); %mV 
RESULT= readmatrix('20000101_002908.csv');
t(:,4)= RESULT(:,1);  
U1(:,4)= RESULT(:,2)*(10^-3); %mV 
U2(:,4)= RESULT(:,3)*(10^-3); %mV 
RESULT= readmatrix('20000101_002932.csv');
t(:,5)= RESULT(:,1);  
U1(:,5)= RESULT(:,2)*(10^-3); %mV 
U2(:,5)= RESULT(:,3)*(10^-3); %mV 
RESULT= readmatrix('20000101_002958.csv');
t(:,6)= RESULT(:,1);  
U1(:,6)= RESULT(:,2)*(10^-3); %mV 
U2(:,6)= RESULT(:,3)*(10^-3); %mV 
RESULT= readmatrix('20000101_003016.csv');
t(:,7)= RESULT(:,1);  
U1(:,7)= RESULT(:,2)*(10^-3); %mV 
U2(:,7)= RESULT(:,3)*(10^-3); %mV 
RESULT= readmatrix('20000101_003051.csv');
t(:,8)= RESULT(:,1);  
U1(:,8)= RESULT(:,2)*(10^-3); %mV 
U2(:,8)= RESULT(:,3)*(10^-3); %mV 
RESULT= readmatrix('20000101_003113.csv');
t(:,9)= RESULT(:,1);  
U1(:,9)= RESULT(:,2)*(10^-3); %mV 
U2(:,9)= RESULT(:,3)*(10^-3); %mV 
RESULT= readmatrix('20000101_003137.csv');
t(:,10)= RESULT(:,1);  
U1(:,10)= RESULT(:,2)*(10^-3); %mV 
U2(:,10)= RESULT(:,3)*(10^-3); %mV 
RESULT= readmatrix('20000101_003156.csv');
t(:,11)= RESULT(:,1);  
U1(:,11)= RESULT(:,2)*(10^-3); %mV 
U2(:,11)= RESULT(:,3)*(10^-3); %mV 
RESULT= readmatrix('20000101_003222.csv');
t(:,12)= RESULT(:,1);  
U1(:,12)= RESULT(:,2)*(10^-3); %mV 
U2(:,12)= RESULT(:,3)*(10^-3); %mV 
RESULT= readmatrix('20000101_003242.csv');
t(:,13)= RESULT(:,1);  
U1(:,13)= RESULT(:,2)*(10^-3); %mV 
U2(:,13)= RESULT(:,3)*(10^-3); %mV 
RESULT= readmatrix('20000101_003301.csv');
t(:,14)= RESULT(:,1);  
U1(:,14)= RESULT(:,2)*(10^-3); %mV 
U2(:,14)= RESULT(:,3)*(10^-3); %mV 
RESULT= readmatrix('20000101_003319.csv');
t(:,15)= RESULT(:,1);  
U1(:,15)= RESULT(:,2)*(10^-3); %mV 
U2(:,15)= RESULT(:,3)*(10^-3); %mV 
RESULT= readmatrix('20000101_003339.csv');
t(:,16)= RESULT(:,1);  
U1(:,16)= RESULT(:,2)*(10^-3); %mV 
U2(:,16)= RESULT(:,3)*(10^-3); %mV  
RESULT= readmatrix('20000101_003359.csv');
t(:,17)= RESULT(:,1);  
U1(:,17)= RESULT(:,2)*(10^-3); %mV 
U2(:,17)= RESULT(:,3)*(10^-3); %mV 
RESULT= readmatrix('20000101_003419.csv');
t(:,18)= RESULT(:,1);  
U1(:,18)= RESULT(:,2)*(10^-3); %mV 
U2(:,18)= RESULT(:,3)*(10^-3); %mV 
RESULT= readmatrix('20000101_003444.csv');
t(:,19)= RESULT(:,1);  
U1(:,19)= RESULT(:,2)*(10^-3); %mV 
U2(:,19)= RESULT(:,3)*(10^-3); %mV 
RESULT= readmatrix('20000101_003506.csv');
t(:,20)= RESULT(:,1);  
U1(:,20)= RESULT(:,2)*(10^-3); %mV 
U2(:,20)= RESULT(:,3)*(10^-3); %mV 
RESULT= readmatrix('20000101_003523.csv');
t(:,21)= RESULT(:,1);  
U1(:,21)= RESULT(:,2)*(10^-3); %mV 
U2(:,21)= RESULT(:,3)*(10^-3); %mV 
%%
SumUmin20 = (sum(U1(:,1))/length(U1(:,1))+sum(U2(:,1))/length(U2(:,1)))/2;
SumUmin10= (sum(U1(:,2))/length(U1(:,2))+sum(U2(:,2))/length(U2(:,2)))/2;
 SumU1 = (sum(U1(:,3))/length(U1(:,3))+sum(U2(:,3))/length(U2(:,3)))/2;
  SumU2 = (sum(U1(:,4))/length(U1(:,4))+sum(U2(:,4))/length(U2(:,4)))/2;
   SumU3 = sum(U2(:,5))/length(U2(:,5));
    SumU4 = (sum(U1(:,6))/length(U1(:,6))+sum(U2(:,6))/length(U2(:,6)))/2;
     SumU5 = (sum(U1(:,7))/length(U1(:,7))+sum(U2(:,7))/length(U2(:,7)))/2;
      SumU6 =(sum(U1(:,8))/length(U1(:,8))+sum(U2(:,8))/length(U2(:,8)))/2;
       SumU7 = (sum(U1(:,9))/length(U1(:,9))+sum(U2(:,9))/length(U2(:,9)))/2;
        SumU8 = (sum(U1(:,10))/length(U1(:,10))+sum(U2(:,10))/length(U2(:,10)))/2;
         SumU9 = (sum(U1(:,11))/length(U1(:,11))+sum(U2(:,11))/length(U2(:,11)))/2;
            SumU10 = (sum(U1(:,12))/length(U1(:,12))+sum(U2(:,12))/length(U2(:,12)))/2;
          SumU11 = (sum(U1(:,13))/length(U1(:,13))+sum(U2(:,13))/length(U2(:,13)))/2;
           SumU12 = (sum(U1(:,14))/length(U1(:,14))+sum(U2(:,14))/length(U2(:,14)))/2;
            SumU13 = (sum(U1(:,15))/length(U1(:,15))+sum(U2(:,15))/length(U2(:,15)))/2;
             SumU14= (sum(U1(:,16))/length(U1(:,16))+sum(U2(:,16))/length(U2(:,16)))/2;
              SumU15 = (sum(U1(:,17))/length(U1(:,17))+sum(U2(:,17))/length(U2(:,17)))/2;
               SumU16 = (sum(U1(:,18))/length(U1(:,18))+sum(U2(:,18))/length(U2(:,18)))/2;
                SumU17 = (sum(U1(:,19))/length(U1(:,19))+sum(U2(:,19))/length(U2(:,19)))/2;
                 SumU18 = (sum(U1(:,20))/length(U1(:,20))+sum(U2(:,20))/length(U2(:,20)))/2;
                  SumU19 = (sum(U1(:,21))/length(U1(:,21))+sum(U2(:,21))/length(U2(:,21)))/2;
%%
x = [-20 -10 0 10 20 30 40 50 60 70 80 90 100 120 140 160 180 200 220 240 260];
y = [SumUmin20 SumUmin10 SumU1 SumU2 SumU3 SumU4 SumU5 SumU6 SumU7 SumU8 SumU9 SumU10 SumU11 SumU12 SumU13 SumU14 SumU15 SumU16 SumU17 SumU18 SumU19]
   plot(x,y ,'o')
   ylabel('U_f, В')
xlabel('R, мм')
grid on
xticks([-20  0  20  40  60 80 100 120 140 160 180 200 220 240 260])
xlim([-20 265])
%% статистика Uf по 2 зонду
for i = 1 : 21
    a1(i) = skewness(U1(:,i)); %асимметрия
    ex1(i) = kurtosis(U1(:,i)); %  эксцесс
    h1(i) = awc_hurst(U1(:,i)); 
end
for i = 1 : 21
    a2(i) = skewness(U2(:,i)); %асимметрия
    ex2(i) = kurtosis(U2(:,i)); %  эксцесс
    h2(i) = awc_hurst(U2(:,i)); 
end
figure()
plot(x,a1 ,'o')
ylabel('Коэффициент асимметрии')
xlabel('R, мм')
grid on
xticks([-20  0  20  40  60 80 100 120 140 160 180 200 220 240 260])
xlim([-20 265])
ylim([-1 1])
hold on
plot(x,a2 ,'o')
legend('зонд 1','зонд 2')

figure()
plot(x,ex1 ,'o')
ylabel('Коэффициент эксцесса')
xlabel('R, мм')
grid on
xticks([-20  0  20  40  60 80 100 120 140 160 180 200 220 240 260])
xlim([-20 265])
ylim([3 16])
hold on
plot(x,ex2 ,'o')
legend('зонд 1','зонд 2')

figure()
plot(x,h1 ,'o')
ylabel('H')
xlabel('R, мм')
grid on
xticks([-20  0  20  40  60 80 100 120 140 160 180 200 220 240 260])
xlim([-20 265])
ylim([0.5 1])
hold on
plot(x,h2 ,'o')
legend('зонд 1','зонд 2')
% txt2zond1 = ['Коэффициент асимметрии=',num2str(y)]
% txt2zond2 = ['Коэффициент эксцесса=' ,num2str(n)]
% txt2zond3 = ['Показатель Хёрста=' ,num2str(h)]
%%
%% статистика Uf по 2 зонду
figure() 
h = histfit(U1(:,1),110,'normal')
y = skewness(U1(:,1)); %асимметрия
n = kurtosis(U1(:,1)); %  эксцесс
h = awc_hurst(U1(:,1)); 
txt1=['Коэффициент асимметрии=',num2str(y)]
txt2=['Коэффициент эксцесса=' ,num2str(n)]
txt3=['Показатель Хёрста=' ,num2str(h)]
text(2.4,8800,txt1)
text(2.4,7600,txt2)
text(2.4,6400,txt3)
ylabel('Количество измеренных точек')
xlabel('U_f, В')

%%
for i = 1 : 21
   [Multifractality1(i), q, h, Dh] = Hoelderf_2007(U1(:,i));
   D1(:, i) = Dh(:,1);
   hd1(:, i) = h(:,1);
   qd1(i, :) = q(1,:);
end
%%
figure()
plot(hd1(:,3), D1(:,3) ,'o')
ylabel('D(h)')
xlabel('h')
grid on
% hold on
% for i = 2 : 21
%     plot(hd1(:,i), D1(:,i) ,'o')
% end
%%
for i = 1 : 21
   [Multifractality2(i), q, h, Dh] = Hoelderf_2007(U2(:,i));
   D2(:, i) = Dh(:,1);
   hd2(:, i) = h(:,1);
   qd2(i, :) = q(1,:);
end
%%
figure()
plot(hd2(:,1), D2(:,1) ,'o')
ylabel('D(h)')
xlabel('h')
grid on
hold on
for i = 5:1:20
    plot(hd2(:,i), D2(:,i) ,'o')
end
legend
%%
figure()
plot(qd1(3,:),hd1(:,3),'o') 
ylabel('h')
xlabel('q')
grid on
% for i = 2:1:21
%     figure()
%     plot(qd1(i,:),hd1(:,i),'o')
% end
% legend
%%
figure()
plot(x, Multifractality1 ,'o')
ylabel('Коэффициент мультифрактальности')
xlabel('R, мм')
grid on
xticks([-20  0  20  40  60 80 100 120 140 160 180 200 220 240 260])
xlim([-20 265])
ylim([0.5 1])
hold on
plot(x,Multifractality2 ,'o')
legend('зонд 1','зонд 2')
%% Фурье спектр 1 
 for i = 1 : 21
   s = U1(:,i)';
    Ts= 0.1*10^(-6);
    y = fft(s);   
    Fs = 1/Ts;
    figure()
    n = length(s);                         
    fshift = (-n/2:n/2-1)*(Fs/n);
    yshift = fftshift(y);
    z=abs(yshift);
    loglog(fshift,abs(yshift))
    xlabel('f, Гц')
    ylabel('S(f)')
    xlim([0 10^5])
    hold on
    ft = fittype('c*x^(-a)');
coeffnames(ft);
 b=fshift(1,50072:50300)';
 a=abs(yshift(1,50072:50300))';
fsf = fit(b,a,ft,'StartPoint',[1,1]) 
coeffsf = coeffvalues(fsf);
 b=fshift(1,50072:50300);
 a=coeffsf(1,2)*b.^-coeffsf(1,1);
 lg = loglog(b,a,'k');
 lg(1).LineWidth = 1.5;
  xlim([0 10^5])
xt = [12040 ];
 yt = [40];
 s = num2str(coeffsf(1,1));
  text(xt,yt,['_~_f ',s],'FontSize',12);
    spadspectra11(1,i)= convertCharsToStrings(s);
   spadspectra1 = double(spadspectra11)
 end
%% Фурье спектр 2 
 for i = 5
   s = U2(:,i)';
    Ts= 0.01*10^(-6);
    y = fft(s);   
    Fs = 1/Ts;
    figure()
    n = length(s);                         
    fshift = (-n/2:n/2-1)*(Fs/n);
    yshift = fftshift(y);
    z=abs(yshift);
    loglog(fshift,abs(yshift))
    xlabel('f, Гц')
    ylabel('S(f)')
    xlim([0 10^6])
    hold on
    ft = fittype('c*x^(-a)');
coeffnames(ft);
 b=fshift(1,50072:50300)';
 a=abs(yshift(1,50072:50300))';
fsf = fit(b,a,ft,'StartPoint',[1,1]) 
coeffsf = coeffvalues(fsf);
 b=fshift(1,50072:50200);
 a= 9.742e+12*b.^-2.34;
 lg = loglog(b,a,'k');
 lg(1).LineWidth = 1.5;
xt = [120040 ];
 yt = [40];
 s = num2str(coeffsf(1,1));
%   text(xt,yt,['_~_f- ',s],'FontSize',12);
   text(xt,yt,['~f^ ^-^2^.^3^4 '],'FontSize',15);
  spadspectra21(1,i)= convertCharsToStrings(s);
   spadspectra2 = double(spadspectra21)
 end
 %%
 figure
rd = 1;
fl = 3;
sf = abs(yshift);
sffilt = sgolayfilt(sf,rd,fl);
figure()
loglog(fshift,sffilt)
xlim([0 10^6])
 %%
 figure()
plot(x,spadspectra1(1,:) ,'o')
ylabel('Показатель спада Фурье-спектра S(f)')
xlabel('R, мм')
grid on
xticks([-20  0  20  40  60 80 100 120 140 160 180 200 220 240 260])
xlim([-20 265])
% ylim([1 2.2])
grid on
hold on
plot(x,spadspectra2(1,:) ,'o')
legend('зонд 1','зонд 2')
%%
x=U1(1:1500,1);
% 
 GK=x;
 da=0.01;
 dk=100;
figure
subplot(311); plot(GK); grid; 
subplot(312); c1=cwt(GK,1:da:dk, 'morl','abslvl',[80 1000]);
subplot(313); c1=cwt(GK,1:da:dk, 'mexh','abslvl',[80 1000]);