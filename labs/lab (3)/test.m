clear; clc; close all;

% Завантаження оригінального зображення
I = imread('/MATLAB Drive/labs/lab (3)/imagesbw.jpeg');
if size(I, 3) == 3
    I = rgb2gray(I);
end
I = im2double(I); % Краще працювати у форматі double для точних обчислень

% Формування оператора перекручення (PSF) - рух камери
LEN = 21;    % Довжина зсуву
THETA = 11;  % Кут зсуву
PSF = fspecial('motion', LEN, THETA);

% 1. ІДЕАЛЬНІ УМОВИ (БЕЗ ШУМУ)
% Створення змазаного зображення
blurred = imfilter(I, PSF, 'conv', 'circular');

% Відновлення (деконволюція)
% Оскільки шуму немає, SNR (відношення сигнал/шум) дорівнює 0
wnr1 = deconvwnr(blurred, PSF, 0);

figure('Name', 'Відновлення ідеального змазаного зображення');
subplot(1,3,1); imshow(I); title('Оригінал');
subplot(1,3,2); imshow(blurred); title('Змазане (motion blur)');
subplot(1,3,3); imshow(wnr1); title('Відновлене (SNR = 0)');

% 2. РЕАЛЬНІ УМОВИ (З ДОДАВАННЯМ ШУМУ)
% Додаємо гаусівський шум до змазаного зображення
noise_var = 0.0001;
blurred_noisy = imnoise(blurred, 'gaussian', 0, noise_var);

% Відновлення зашумленого зображення
% Спершу спробуємо відновити з SNR = 0 (ніби ігноруємо наявність шуму)
wnr2_bad = deconvwnr(blurred_noisy, PSF, 0);

% Тепер відновимо з урахуванням оцінки SNR
% Оцінимо дисперсію самого зображення для розрахунку SNR
signal_var = var(I(:));
estimated_snr = signal_var / noise_var;
wnr3_better = deconvwnr(blurred_noisy, PSF, 1/estimated_snr);

figure('Name', 'Відновлення змазаного зображення з шумом');
subplot(1,3,1); imshow(blurred_noisy); title('Змазане + Шум');
subplot(1,3,2); imshow(wnr2_bad); title('Відновлене (ігноруючи шум)');
subplot(1,3,3); imshow(wnr3_better); title('Відновлене (враховуючи SNR)');