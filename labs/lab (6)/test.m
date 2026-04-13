% Очищення робочого простору
close all; clear; clc;

% Завдання 1 та 2: Завантаження зображень та перетворення у чорно-біле
F_color = imread('/MATLAB Drive/labs/lab (5)/Cat_November_2010-1a.jpg'); % Завантаження стандартного кольорового зображення
I_gray = rgb2gray(F_color);
figure; imshow(I_gray); title('Вихідне чорно-біле зображення');

% Переведення у формат double для уникнення помилок округлення
I = im2double(I_gray);

% Завдання 3: Поблочне дискретне косинусне перетворення (ДКП)
N = 8; % Розмір блоку 8x8
T = dctmtx(N);
dct_func = @(block_struct) T * block_struct.data * T';
B = blockproc(I, [N N], dct_func, 'PadPartialBlocks', true);

% Завдання 4: Відображення результату поблочного ДКП
figure; imshow(log(abs(B)), []); title('Поблочний ДКП-спектр (логарифмічний масштаб)');
colormap(gca, jet); colorbar;

% Завдання 5: Відновлення зображення за його ДКП-спектром
invdct_func = @(block_struct) T' * block_struct.data * T;
I2 = blockproc(B, [N N], invdct_func, 'PadPartialBlocks', true);
figure; imshow(I2); title('Відновлене зображення (без втрат)');

% Завдання 6: Рівномірне квантування результатів ДКП
quant_step1 = 0.05; 
B_quant1 = quant_step1 * round(B / quant_step1);
I_quant1 = blockproc(B_quant1, [N N], invdct_func);
figure; imshow(I_quant1); title('Відновлене після квантування (крок 0.05)');

quant_step2 = 0.2; 
B_quant2 = quant_step2 * round(B / quant_step2);
I_quant2 = blockproc(B_quant2, [N N], invdct_func);
figure; imshow(I_quant2); title('Відновлене після квантування (крок 0.2)');

% Завдання 7: Квантування коефіцієнтів ДКП за допомогою спеціальної матриці
mask = [1 1 1 1 0 0 0 0;
        1 1 1 0 0 0 0 0;
        1 1 0 0 0 0 0 0;
        1 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0];

B_mask = blockproc(B, [N N], @(block_struct) mask .* block_struct.data, 'PadPartialBlocks', true);

% Завдання 8: Відновлення зображення за маскованим ДКП-спектром
I_mask_restored = blockproc(B_mask, [N N], invdct_func);
figure; imshow(I_mask_restored); title('Відновлене після застосування маски');