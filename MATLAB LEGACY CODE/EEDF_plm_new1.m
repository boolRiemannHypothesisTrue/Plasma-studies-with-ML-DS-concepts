%% Считывание файла
clear; clc;
RESULT= readmatrix('20000101_031045.csv');%НАДО МЕНЯТЬ
t= RESULT(:,1);  
U1= RESULT(:,2)*(10^-3); %mV в V
U2=RESULT(:,3)*(10^-3);  %mV в V
%% Параметры в эксперименте
R = 25; %Ом
r=0.25*10^(-3); %Радиус зонда м
h=6*10^(-3); %Длина зонды м
S = 2*pi*r*(r+h); %Площадь зонда м^2
mi=6.64*10^(-27); %Масса иона(газ)

%% Графический вывод входных данных
figure;
plot(t,U1,t,U2)
ylabel('U, В')
xlabel('t, мкс')
%% Vibor podachi
answer = questdlg('Тип подачи напряжения?', ...
	'Voltage Menu', ...
	'треугольник','пила','треугольник');
% Handle response
switch answer
    case 'треугольник'
        disp([answer ' coming right up.'])
        voltage = 1;
    case 'пила'
        disp([answer ' coming right up.'])
        voltage = 2;
end
%% Выбор участка ВАХ
if voltage == 1
    xmax = U1(1,1);
    for i = 1 : length(U1)/2
        if xmax < U1(i,1)
            xmax = U1(i,1);
            k = i;
        end
    end
    xmin = xmax;
    for i = length(U1)/2:length(U1)
        if xmin > U1(i,1)
            xmin = U1(i,1);
            j = i;
        end
    end
    diap = (k:j); %Диапазон точек для вах(если брать -100+100 поменять kitog на k)
else
    xmin = U2(1,1);
    for i = 1 : length(U2)/2
        if xmin > U2(i,1)
            xmin = U2(i,1);
            k = i;
        end
    end
    xmax = xmin;
    for i = length(U2)/2 : length(U2)
        if xmax < U2(i,1)
            xmax = U2(i,1);
            j = i;
        end
    end
    % hold on
    % plot(t(k:j,1),U2(k:j,1))
    for i = k : j
        if xmin < -60
            xmin = U2(i,1);
            kitog = i;
        end
    end
    diap = (k:j); %Диапозон точек для вах(если брать -100+100 поменять kitog на k)
end
%% VAH
diap = (k:j); %Диапазон точек для вах(если брать -100+100 поменять kitog на k)
y=U1(diap,1)-U2(diap,1);
I = y/R;
U = U1(diap,1);
figure;
plot(U, I);
xlabel('U, В')
ylabel('I, A')
grid on
%% filter
figure
rd = 1;
fl = 15;
If = sgolayfilt(I,rd,fl);
subplot(2,1,1)
plot(U,I)
title('Оригинальный сигнал')
xlabel('U, В')
ylabel('I, A')
grid on
subplot(2,1,2)
plot(U,If)
title('Фильтрованный сигнал')
xlabel('U, В')
ylabel('I, A')
grid on
%% I-Is=Ie
Is = min(If); %Ионный ток насыщения из VAH НАДО МЕНЯТЬ
Ie = I - Is;
Ief = If - Is;
figure;
subplot(2,1,1)
plot(U,Ie);
xlabel('U, В')
ylabel('Ie, A')
title('Оригинальный сигнал')
grid on
subplot(2,1,2)
plot(U,Ief);
xlabel('U, В')
ylabel('Ie, A')
title('Фильтрованный сигнал')
grid on
%% 1 proizv
y1 = diff(Ief);
figure
rd = 1;
fl = 21;
Ief1 = sgolayfilt(y1,rd,fl);
subplot(2,1,1)
plot(U(1:(length(U)-1),1),y1)
title('Оригинальный сигнал')
xlabel('U, В')
ylabel('dI^2/dV^2')
grid
subplot(2,1,2)
plot(U(1:(length(U)-1),1),Ief1)
title('Фильтрованный сигнал')
xlabel('U, В')
ylabel('dI^2/dV^2')
grid on
%% 2 proizv
y2 = diff(Ief1);
figure
rd = 1;
fl = 21;
Ief2 = sgolayfilt(y2,rd,fl);
subplot(2,1,1)
plot(U(1:(length(U)-2),1),y2)
title('Оригинальный сигнал')
xlabel('U, В')
ylabel('dI^2/dV^2')
grid
subplot(2,1,2)
plot(U(1:(length(U)-2),1),Ief2)
title('Фильтрованный сигнал')
xlabel('U, В')
ylabel('dI^2/dV^2')
grid on
%% нахождение Vp
    imax = Ief2(1,1);
    for i = 1 : length(Ief2)
        if imax < Ief2(i,1)
            imax = Ief2(i,1);
            p = i;
        end
    end
    imin = Ief2(1,1);
    for i = 1 : length(Ief2)
        if imin > Ief2(i,1)
            imin = Ief2(i,1);
            d = i;
        end
    end
    x = Ief2(d,1);
    for i = d : p
        if x < 0
            x = Ief2(i,1);
            kit = i;
        else
            break
        end
    end
    intitog = kit;
    Vp = U(intitog,1) + ((U(intitog-1,1)-U(intitog,1))*(0-Ief2(intitog,1)))/(Ief2(intitog-1,1) - Ief2(intitog,1)); 
%% 
Uef2= U(1:(length(U)-2),1);
e = 1.6*10^(-19);
me = 9.1*10^(-31);
%Uz = -2.9 + U1(diap); %НАДО МЕНЯТЬ Up
Uz = Vp - U1(diap);
E1=Uz(1:length(Uz)-2,1);
i=1:1:(length(Uz)-2);
f2 = ((2*me)/(S*e^2))*sqrt((2.*E1(i,1))/me).*Ief2(i,1);
fp =  ((2*sqrt(2*me))/(S*e^3)).*Ief2(i,1);
fp1 = (4/e^2*S*E1(i,1)).*sqrt(me*E1(i,1)/(2*e)).*Ief2(i,1);
f_1 = 2*(2*me)^(1/2)*(S*e^3)^(-1)*(Ief2(i,1));
figure('Color','w');
%plot(E1(1:(length(Uz)-2),1),f1,'*','Color','green');
set(gca, 'YScale', 'log')
hold on
rd = 1;
fl = 15;
f11 = sgolayfilt(f2*10^-7,rd,fl);
plot(E1,f11,'o')
xlabel('E, eV')
ylabel('EEDF, eV^-^3^/^2 m^-^3')
%ylim([10e21 inf])
xlim([0 30])
grid on
figure('Color','w');
plot(E1(1:(length(Uz)-2),1),f11,'o')
%set(gca, 'YScale', 'log')
xlabel('E, eV')
ylabel('EEDF, eV^-^1 m^-^3')
%ylim([10e21 inf])
ylim([0 inf])
xlim([0 50])
grid on

%%
% for i=1:(length(Uz)-2)
%     EEDF(i,1)= f11(i,1)*sqrt(E1(i,1));
% end
% figure()
% semilogy(E1(1:(length(Uz)-2),1),EEDF,'o')
% ylim([0 inf])
% xlim([0 70])
% grid on

%% Teff
for i = 1 : length(E1)
    if E1(i) > 0
        k = i;
        break
    end
end
for i = k : length(E1)
    if E1(i) < 25
        j = i;
    else 
    break
    end
end
p=1;
for i = k : j
    if real(f11(i)) > 0
        EEDF1(p) = real(f11(i));
        energy1(p) = E1(i);
        p=p+1;
    end
end
figure()
EEDFitog = EEDF1';
energy = energy1';
plot(energy,EEDFitog,'o')
xlabel('E, eV')
ylabel('EEDF, eV^-^1 m^-^3')
%ylim([10e21 inf])
ylim([0 inf])
grid on
xlim([0 30])
% energy = E1(k:length(E1),1);
% EEDF = real(f11(125:162,1));
Uef2= U(1:(length(U)-2),1);
Ne = trapz(energy, EEDFitog)
% Ne1 = (2.*sqrt(2*me)/(e*S1)).*trapz(Uef2, Ief2.*sqrt(Uef2/e))
Teff  = (2/(3*Ne)).*trapz(energy, EEDFitog.*energy)
% Teff1 = (4*sqrt(2*me))/(3*Ne1*S1).*trapz(Uef2, Ief2.*(Uef2/e).^(3/2))
%%
% 
% x = 0:0.2:30;
% figure
% plot(energy,EEDFitog,'o')
% hold on
% gepmaxwell = Ne * 2/pi * Teff^(-3/2)*exp(-energy/Teff);
% maxwell = ((2*pi)/(pi*Teff)^(3/2)).*sqrt(x).*exp(-x/(Teff));
% maxwell1 = maxwell*4.2*10^18;
% plot(x, maxwell1,'-*')
% xlabel('E, еВ')
% ylabel('EEDF, еВ^-^1 м^-^3')
% ylim([0 inf])
% xlim([0 30])
% grid on
% % Ne1 = trapz(x, maxwell1.*sqrt(x))
% legend('Дрюйвестейн','Максвелл')