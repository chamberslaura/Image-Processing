clc;
close all;
clear;
fontSize = 12;

% Load image
tire = imread('tire.tif');

% Plot image and histogram
figure;
set(gcf, 'Position', get(0,'Screensize'));
subplot(2,5,1);
imshow(tire);
title('Original', 'FontSize', fontSize);
subplot(2,5,6);
imhist(tire);
title('Original Histogram', 'FontSize', fontSize);

% Plot negative image and histogram
tire_negative = imcomplement(tire);
subplot(2,5,2);
imshow(tire_negative);
title('Negative', 'FontSize', fontSize);
subplot(2,5,7);
imhist(tire_negative);
title('Negative Histogram', 'FontSize', fontSize);

% Power law transformation gamma = 0.5
gamma = 0.5;
tire_gamma1 = imadjust(tire, [], [], gamma);
subplot(2,5,3);
imshow(tire_gamma1);
title('Gamma = 0.5', 'FontSize', fontSize);
subplot(2,5,8);
imhist(tire_gamma1);
title('Gamma = 0.5 Histogram', 'FontSize', fontSize);

% Power law transformation gamma = 1.3
gamma = 1.3;
tire_gamma2 = imadjust(tire, [], [], gamma);
subplot(2,5,4);
imshow(tire_gamma2);
title('Gamma = 1.3', 'FontSize', fontSize);
subplot(2,5,9);
imhist(tire_gamma2);
title('Gamma = 1.3 Histogram', 'FontSize', fontSize);

% Histogram equalization
tire_eq = histeq(tire);
subplot(2,5,5);
imshow(tire_eq);
title('histeq()', 'FontSize', fontSize);
subplot(2,5,10);
imhist(tire_eq);
title('histeq() Histogram', 'FontSize', fontSize);