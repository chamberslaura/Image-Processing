clc;
close all;
clear;
fontSize = 12;

% Load images
lena = imread('lena.tiff');
cameraman = imread('cameraman.tif');

% Convert images to grayscale if not already grayscale
lena_gray = convert2grayscale(lena);
cameraman_gray = convert2grayscale(cameraman);

% DOWN-SAMPLE
% Reduce resolution of images using bilinear interpolation
lena_gray_down = imresize(lena_gray, 0.25, 'bilinear');
cameraman_gray_down = imresize(cameraman_gray, 0.25, 'bilinear');

% UP-SAMPLE
% Perform digital zooming via nearest neighbour interpolation
lena_gray_up_nearest = imresize(lena_gray_down, 4, 'nearest');
cameraman_gray_up_nearest = imresize(cameraman_gray_down, 4, 'nearest');

% Perform digital zooming via bilinear interpolation
lena_gray_up_bilinear = imresize(lena_gray_down, 4, 'bilinear');
cameraman_gray_up_bilinear = imresize(cameraman_gray_down, 4, 'bilinear');

% Perform digital zooming via bicubic interpolation
lena_gray_up_bicubic = imresize(lena_gray_down, 4, 'bicubic');
cameraman_gray_up_bicubic = imresize(cameraman_gray_down, 4, 'bicubic');

% Plot images
figure;
set(gcf, 'Position', get(0,'Screensize'));
subplot(2, 3, 1);
imshow(lena_gray, []);
title('Original', 'FontSize', fontSize);
subplot(2, 3, 2);
imshow(lena_gray_down, []);
title('Down-Sampled', 'FontSize', fontSize);
subplot(2, 3, 3);
imshow(lena_gray_up_nearest, []);
title('Nearest Neighbour', 'FontSize', fontSize);
subplot(2, 3, 5);
imshow(lena_gray_up_bilinear, []);
title('Bilinear', 'FontSize', fontSize);
subplot(2, 3, 6);
imshow(lena_gray_up_bicubic, []);
title('Bicubic', 'FontSize', fontSize);

figure;
set(gcf, 'Position', get(0,'Screensize'));
subplot(2, 3, 1);
imshow(cameraman_gray, []);
title('Original', 'FontSize', fontSize);
subplot(2, 3, 2);
imshow(cameraman_gray_down, []);
title('Down-Sampled', 'FontSize', fontSize);
subplot(2, 3, 3);
imshow(cameraman_gray_up_nearest, []);
title('Nearest Neighbour', 'FontSize', fontSize);
subplot(2, 3, 5);
imshow(cameraman_gray_up_bilinear, []);
title('Bilinear', 'FontSize', fontSize);
subplot(2, 3, 6);
imshow(cameraman_gray_up_bicubic, []);
title('Bicubic', 'FontSize', fontSize);

% Compute PSNR between original and up-sampled images
PSNR_lena_nearest = PSNR(lena_gray, lena_gray_up_nearest)
PSNR_lena_bilinear = PSNR(lena_gray, lena_gray_up_bilinear)
PSNR_lena_bicubic = PSNR(lena_gray, lena_gray_up_bicubic)

PSNR_cameraman_nearest = PSNR(cameraman_gray, cameraman_gray_up_nearest)
PSNR_cameraman_bilinear = PSNR(cameraman_gray, cameraman_gray_up_bilinear)
PSNR_cameraman_bicubic = PSNR(cameraman_gray, cameraman_gray_up_bicubic)


