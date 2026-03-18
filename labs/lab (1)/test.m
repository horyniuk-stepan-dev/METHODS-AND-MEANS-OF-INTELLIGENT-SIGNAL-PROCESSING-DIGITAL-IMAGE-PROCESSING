clear, clc, close all

path1 = '/MATLAB Drive/labs/lab (1)/Cat_November_2010-1a.jpg';
path2 = '/MATLAB Drive/labs/lab (1)/imagesbw.jpeg'
catimg = imread(path1);
elfantimg = imread(path2);


info1 = imfinfo(path1);
disp('Інформація про 1 зображення:');
disp(info1);
info2 = imfinfo(path2);
disp('Інформація про 2 зображення:');
disp(info2);

imwrite(catimg, '/MATLAB Drive/labs/lab1/saved_cat_image.png');
imwrite(elfantimg, '/MATLAB Drive/labs/lab1/saved_elefant_image.png');

cat_gray = rgb2gray(catimg);
elfant_gray = rgb2gray(elfantimg);

figure('Name', 'Гістограми та контрастування');

subplot(2,2,1); imhist(cat_gray); title('Гістограма: Кіт');
subplot(2,2,2); imhist(elfant_gray); title('Гістограма: Слон');

cat_adj = imadjust(cat_gray);
elfant_adj = imadjust(elfant_gray);

subplot(2,2,3); imshow(cat_adj); title('Кіт: Підвищений контраст');
subplot(2,2,4); imshow(elfant_adj); title('Слон: Підвищений контраст');

cat_neg = imadjust(catimg, [0 1], [1 0], 1.5);
elfant_neg_adj = imadjust(elfant_gray, [0 1], [1 0], 1.5);

figure('Name', 'Негативи');

subplot(1,2,1); 
imshow(cat_neg); 
title('Негатив кота');

subplot(1,2,2); 
imshow(elfant_neg_adj); 
title('Негатив слона');
