clc;
close all;
clear;
fontSize = 12;

% Load images
lena = imread('lena1.tiff');

% Convert images to grayscale and normalize intensities from 0 to 1
lena_gray = convert2grayscale(lena);
lena_gray_norm = double(lena_gray)/255;

% Impulse functions
h1 = (1/6)*ones(1,6)
h2 = h1'
h3 = [-1 1]

% Convolve Lena and impulse functions
lena1 = conv2(lena_gray_norm, h1);
lena2 = conv2(lena_gray_norm, h2);
lena3 = conv2(lena_gray_norm, h3);

% Plot images
figure;
set(gcf, 'Position', get(0,'Screensize'));
subplot(2, 2, 1);
imshow(lena_gray_norm);
title('Original', 'FontSize', fontSize);
subplot(2, 2, 2);
imshow(lena1);
title('Impulse function h1', 'FontSize', fontSize);
subplot(2, 2, 3);
imshow(lena2);
title('Impulse function h2', 'FontSize', fontSize);
subplot(2, 2, 4);
imshow(lena3);
title('Impulse function h3', 'FontSize', fontSize);

