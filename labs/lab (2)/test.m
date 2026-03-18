clear; clc; close all;

% Завантаження оригінального зображення
I = imread('/MATLAB Drive/labs/lab (2)/imagesbw.jpeg');
I = rgb2gray(I);


% Зашумлення зображення різними типами перешкод
J_gauss = imnoise(I, 'gaussian', 0, 0.01);
J_salt = imnoise(I, 'salt & pepper', 0.02);

figure('Name', 'Оригінал та зашумлені зображення');
subplot(1,3,1); imshow(I); title('Оригінал');
subplot(1,3,2); imshow(J_gauss); title('Гаусівський шум');
subplot(1,3,3); imshow(J_salt); title('Шум "Сіль та перець"');

% Лінійна фільтрація (ФНЧ та ФВЧ)
h_low = ones(3,3) / 9; 
h_high = [-1 -1 -1; -1 9 -1; -1 -1 -1]; 

I_low_gauss = imfilter(J_gauss, h_low);
I_high_orig = imfilter(I, h_high); 

figure('Name', 'Лінійна фільтрація');
subplot(1,2,1); imshow(I_low_gauss); title('ФНЧ (згладжування шуму)');
subplot(1,2,2); imshow(I_high_orig); title('ФВЧ (підкреслення контурів)');

% Адаптивна вінерівська фільтрація
K_wiener = wiener2(J_gauss, [5 5]);

% Медіанна фільтрація
K_med_salt = medfilt2(J_salt);
K_med_gauss = medfilt2(J_gauss);

figure('Name', 'Адаптивна та Нелінійна фільтрація');
subplot(1,3,1); imshow(K_wiener); title('Вінерівський (Гаус)');
subplot(1,3,2); imshow(K_med_salt); title('Медіанний (Сіль/Перець)');
subplot(1,3,3); imshow(K_med_gauss); title('Медіанний (Гаус)');