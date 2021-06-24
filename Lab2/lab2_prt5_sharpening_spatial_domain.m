clc;
close all;
clear;

% Load images, convert to grayscale, and normalize intensities
cameraman = imread('cameraman1.tif');
cameraman_gray = convert2grayscale(cameraman);
cameraman_gray_norm = double(cameraman_gray)/255;

% Apply the Gaussian filter
H_gauss = fspecial('gaussian', [7 7], 1);
camerman_gauss = imfilter(cameraman_gray_norm, H_gauss);

% Manipulate the original and subtracted image
camerman_subtract = cameraman_gray_norm - camerman_gauss;
cameraman_add = cameraman_gray_norm + camerman_subtract;
cameraman_mult_add = cameraman_gray_norm + (0.5*camerman_subtract);

% Plot images
fontSize = 12;
figure;
set(gcf, 'Position', get(0,'Screensize'));
subplot(2, 2, 1);
imshow(camerman_gauss);
title('Gaussian', 'FontSize', fontSize);
subplot(2, 2, 2);
imshow(camerman_subtract);
title('Subtracted', 'FontSize', fontSize);
subplot(2, 2, 3);
imshow(cameraman_add);
title('Original + Subtracted', 'FontSize', fontSize);
subplot(2, 2, 4);
imshow(cameraman_mult_add);
title('Original + 0.5*Subtracted', 'FontSize', fontSize);
