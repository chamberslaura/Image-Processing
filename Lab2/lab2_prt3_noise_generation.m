clc;
close all;
clear;
fontSize = 12;

% Generate test image
f = [0.3*ones(200,100) 0.7*ones(200,100)];

% Add noise to test image
f_gauss = imnoise(f,'gaussian',0,0.01);
f_salt_pepper = imnoise(f,'salt & pepper',0.05);
f_speckle = imnoise(f,'speckle',0.04);

% Plot images
figure;
set(gcf, 'Position', get(0,'Screensize'));
subplot(2, 4, 1);
imshow(f);
title('Original', 'FontSize', fontSize);
subplot(2, 4, 2);
imshow(f_gauss);
title('Gaussian', 'FontSize', fontSize);
subplot(2, 4, 3);
imshow(f_salt_pepper);
title('Salt & Pepper', 'FontSize', fontSize);
subplot(2, 4, 4);
imshow(f_speckle);
title('Speckle', 'FontSize', fontSize);

% Plot histograms
subplot(2, 4, 5);
imhist(f);
subplot(2, 4, 6);
imhist(f_gauss);
subplot(2, 4, 7);
imhist(f_salt_pepper);
subplot(2, 4, 8);
imhist(f_speckle);