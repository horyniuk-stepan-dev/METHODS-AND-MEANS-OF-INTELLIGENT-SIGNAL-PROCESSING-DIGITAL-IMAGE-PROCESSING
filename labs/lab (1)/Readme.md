# Лабораторна робота №1
## Основи роботи з цифровими зображеннями в MATLAB

---

## Мета роботи

Ознайомлення з базовими функціями завантаження, відображення, збереження та початкової обробки цифрових зображень.

---

## Хід роботи

### 1. Підготовка середовища

Очищення робочого простору та закриття вікон:

```matlab
clear, clc, close all
```

---

### 2. Завантаження та аналіз зображень

Використано функцію `imread` для зчитування файлів `Cat_November_2010-1a.jpg` та `imagesbw.jpeg`. За допомогою `imfinfo` отримано детальну інформацію про формат, розміри та глибину кольору.

```matlab
path1 = '/MATLAB Drive/labs/lab (1)/Cat_November_2010-1a.jpg';
path2 = '/MATLAB Drive/labs/lab (1)/imagesbw.jpeg';
catimg = imread(path1);
elfantimg = imread(path2);

info1 = imfinfo(path1);
disp('Інформація про 1 зображення:');
disp(info1);
info2 = imfinfo(path2);
disp('Інформація про 2 зображення:');
disp(info2);
```

---

### 3. Збереження

Файли були успішно переформатовані та збережені як `saved_cat_image.png` та `saved_elefant_image.png`.

```matlab
imwrite(catimg, '/MATLAB Drive/labs/lab1/saved_cat_image.png');
imwrite(elfantimg, '/MATLAB Drive/labs/lab1/saved_elefant_image.png');
```

---

### 4. Перетворення у градації сірого

Виконано перетворення кольорового зображення кота у напівтонове за допомогою функцій `rgb2gray`.

```matlab
cat_gray = rgb2gray(catimg);
elfant_gray = rgb2gray(elfantimg);
```

---

### 5. Гістограмний аналіз

Побудовано гістограми розподілу яскравості для обох тестових зображень за допомогою `imhist` для аналізу динамічного діапазону.

```matlab
figure('Name', 'Гістограми та контрастування');

subplot(2,2,1); imhist(cat_gray); title('Гістограма: Кіт');
subplot(2,2,2); imhist(elfant_gray); title('Гістограма: Слон');
```

---

### 6. Корекція контрастності

Проведено підвищення контрастності за допомогою функції `imadjust`, що дозволило краще візуалізувати деталі у світлих та темних областях.

```matlab
cat_adj = imadjust(cat_gray);
elfant_adj = imadjust(elfant_gray);

subplot(2,2,3); imshow(cat_adj); title('Кіт: Підвищений контраст');
subplot(2,2,4); imshow(elfant_adj); title('Слон: Підвищений контраст');
```

**Результат:**
![Гістограми та контрастування](%D0%93%D1%96%D1%81%D1%82%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%B8%20%D1%82%D0%B0%20%D0%BA%D0%BE%D0%BD%D1%82%D1%80%D0%B0%D1%81%D1%82%D1%83%D0%B2%D0%B0%D0%BD%D0%BD%D1%8F.png)

---

### 7. Створення негативів

Реалізовано негативне перетворення зображень шляхом інверсії діапазону значень яскравості `[0, 1]` -> `[1, 0]` з гамма-корекцією `1.5`.

```matlab
cat_neg = imadjust(catimg, [0 1], [1 0], 1.5);
elfant_neg_adj = imadjust(elfant_gray, [0 1], [1 0], 1.5);

figure('Name', 'Негативи');

subplot(1,2,1); 
imshow(cat_neg); 
title('Негатив кота');

subplot(1,2,2); 
imshow(elfant_neg_adj); 
title('Негатив слона');
```

**Результат:**
![негативи](%D0%BD%D0%B5%D0%B3%D0%B0%D1%82%D0%B8%D0%B2%D0%B8.png)

---

## Висновок

Під час виконання роботи було освоєно базові інструменти Image Processing Toolbox для маніпуляції зображеннями, аналізу їх структури та виконання найпростіших перетворень яскравості.


## Повний текст програми

```matlab
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
```

## Попередній перегляд зображень у Markdown

### Вхідні зображення
![Cat](Cat_November_2010-1a.jpg)
![Image](imagesbw.jpeg)
