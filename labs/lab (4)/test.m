clear; clc; close all;

% 1-2. Завантаження та підготовка зображення
f = imread('/MATLAB Drive/labs/lab (4)/Cat_November_2010-1a.jpg');
if size(f, 3) == 3
    f = rgb2gray(f);
end
f = im2double(f); % Переводимо у double для точності обчислень

% 3-4. Обчислення ДПФ та візуалізація спектра
F = fft2(f);
S = abs(F);
Fc = fftshift(S); % Зсув нульової частоти в центр
Slog = log(1 + Fc); % Логарифмічний масштаб для наочності

figure('Name', 'Оригінал та його спектр');
subplot(1,2,1); imshow(f); title('Вихідне зображення');
subplot(1,2,2); imshow(Slog, []); title('Спектр (лог. масштаб)');

% Відновлення зображення за спектром (ОДПФ)
Fdc = ifftshift(Fc); % Зворотний зсув
f_restored = ifft2(F);

figure('Name', 'Відновлення після прямого та зворотного ДПФ');
imshow(abs(f_restored), []); title('Відновлене зображення');

% 5-8. Фільтрація у частотній області
[M, N] = size(f);
sigma = 20; % Параметр розмиття (чим менше, тим вужчий спектр пропускається)
h = fspecial('gaussian', [M N], sigma); % Фільтр розміром із зображення

% Частотна характеристика фільтра
H = fft2(h);
Hc = fftshift(abs(H));
Hlog = log(1 + Hc);

% Застосування фільтра (множення спектрів)
Filtered_F = F .* H; 
Filtered_Fc = fftshift(abs(Filtered_F));
Filtered_Slog = log(1 + Filtered_Fc);

% Зворотне перетворення для отримання відфільтрованого зображення
f_filtered = abs(ifft2(Filtered_F));
f_filtered = fftshift(f_filtered);
figure('Name', 'Фільтрація у частотній області');
subplot(1,3,1); imshow(Hlog, []); title('АЧХ фільтра');
subplot(1,3,2); imshow(Filtered_Slog, []); title('Спектр після фільтрації');
subplot(1,3,3); imshow(f_filtered, []); title('Відфільтроване зображення');