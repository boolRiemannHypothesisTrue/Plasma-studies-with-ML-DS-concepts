% Примерные экспериментальные данные с шумом
Fs = 1000;               % Частота дискретизации (Гц)
t = 0:1/Fs:1-1/Fs;       % Вектор времени
f_signal = 5;            % Частота основного сигнала (Гц)
signal = sin(2*pi*f_signal*t);  % Чистый сигнал

% Добавление шума
f_noise_low = 30;        % Нижняя частота шума (Гц)
f_noise_high = 100;      % Верхняя частота шума (Гц)
noise = 0.5 * sin(2*pi*f_noise_low*t) + 0.5 * sin(2*pi*f_noise_high*t);  % Шум в диапазоне от 30 Гц до 100 Гц
high_freq_component = 0.3 * sin(2*pi*150*t);  % Важная высокочастотная компонента
noisy_signal = signal + noise + high_freq_component + 0.2*randn(size(t));  % Сигнал с шумом

% Выполнение БПФ
N = length(noisy_signal);
f = Fs * (0:(N/2)) / N;            % Масштаб частот
signal_fft = fft(noisy_signal);     % Прямое БПФ для зашумленного сигнала

% Определение диапазона частот для фильтрации (Полосовой вырезающий фильтр)
lower_cutoff_freq = 30;    % Нижняя частота фильтра (Гц)
upper_cutoff_freq = 100;   % Верхняя частота фильтра (Гц)

% Преобразование граничных частот в индексы спектра
lower_cutoff_index = round(lower_cutoff_freq * N / Fs);
upper_cutoff_index = round(upper_cutoff_freq * N / Fs);

% Применение фильтрации: обнуляем частоты в заданном диапазоне
filtered_fft = signal_fft;
filtered_fft(lower_cutoff_index:upper_cutoff_index) = 0;  % Обнуляем частоты в пределах диапазона

% Выполнение обратного БПФ
filtered_signal = real(ifft(filtered_fft));

% Визуализация
figure;

% Чистый сигнал и зашумленный сигнал
subplot(3,1,1);
plot(t, signal, 'k', 'LineWidth', 1.5); hold on;
plot(t, noisy_signal, 'r', 'LineWidth', 1);
title('$Original\ and\ Noisy\ Signal$', 'Interpreter', 'latex');
xlabel('$Time\ (s)$', 'Interpreter', 'latex');
ylabel('$Amplitude$', 'Interpreter', 'latex');
legend({'$Original$', '$Noisy$'}, 'Interpreter', 'latex');
grid on;

% Фильтрованный сигнал
subplot(3,1,2);
plot(t, filtered_signal, 'b', 'LineWidth', 1.5);
title('$Filtered\ Signal\ (Bandstop\ FFT)$', 'Interpreter', 'latex');
xlabel('$Time\ (s)$', 'Interpreter', 'latex');
ylabel('$Amplitude$', 'Interpreter', 'latex');
grid on;

% Частотные спектры до и после фильтрации
noisy_signal_fft = abs(fft(noisy_signal) / N);
filtered_signal_fft = abs(fft(filtered_signal) / N);

subplot(3,1,3);
plot(f, noisy_signal_fft(1:N/2+1), 'r', 'LineWidth', 1.5);
hold on;
plot(f, filtered_signal_fft(1:N/2+1), 'b', 'LineWidth', 1.5);
title('$Spectrum\ Before\ and\ After\ Bandstop\ Filtering$', 'Interpreter', 'latex');
xlabel('$Frequency\ (Hz)$', 'Interpreter', 'latex');
ylabel('$Magnitude$', 'Interpreter', 'latex');
legend({'$Noisy$', '$Filtered$'}, 'Interpreter', 'latex');
grid on;
