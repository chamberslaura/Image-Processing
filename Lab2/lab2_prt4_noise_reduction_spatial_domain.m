clc;
close all;
clear;

% Load images, convert to grayscale, and normalize intensities
lena = imread('lena1.tiff');
lena_gray = convert2grayscale(lena);
lena_gray_norm = double(lena_gray)/255;

% Add noise to lena_gray_norm
lena_gauss = imnoise(lena_gray_norm,'gaussian',0,0.002);
lena_salt_pepper = imnoise(lena_gray_norm,'salt & pepper',0.05);

% Create filters and plot
H_avg3 = fspecial('average', [3 3]);
H_avg7 = fspecial('average', [7 7]);
H_gauss = fspecial('gaussian', [7 7], 1);
plotFilter(H_avg3, '3x3 Averaging Filter');
plotFilter(H_avg7, '7x7 Averaging Filter');
plotFilter(H_gauss, '7x7 Gaussian Filter');

% Filter images
lena_filter1 = imfilter(lena_gauss, H_avg3);
lena_filter2 = imfilter(lena_gauss, H_avg7);
lena_filter3 = imfilter(lena_gauss, H_gauss);
lena_filter4 = imfilter(lena_salt_pepper, H_gauss);
lena_filter5 = imfilter(lena_salt_pepper, H_avg7);
lena_filter6 = medfilt2(lena_salt_pepper);

% Calculate PSNR
psnr_gauss = PSNR_norm(lena_gray_norm, lena_gauss)
psnr_salt_pepper = PSNR_norm(lena_gray_norm, lena_salt_pepper)
psnr_filter1 = PSNR_norm(lena_gray_norm, lena_filter1)
psnr_filter2 = PSNR_norm(lena_gray_norm, lena_filter2)
psnr_filter3 = PSNR_norm(lena_gray_norm, lena_filter3)
psnr_filter4 = PSNR_norm(lena_gray_norm, lena_filter4)
psnr_filter5 = PSNR_norm(lena_gray_norm, lena_filter5)
psnr_filter6 = PSNR_norm(lena_gray_norm, lena_filter6)

% Plot images
plot3Images(lena_gray_norm, lena_gauss, lena_filter1, 'Gaussian Noise', ...
    '3x3 Averaging Filter', psnr_gauss, psnr_filter1);
plot3Images(lena_gray_norm, lena_gauss, lena_filter2, 'Gaussian Noise', ...
    '7x7 Averaging Filter', psnr_gauss, psnr_filter2);
plot3Images(lena_gray_norm, lena_gauss, lena_filter3, 'Gaussian Noise', ...
    '7x7 Gaussian Filter', psnr_gauss, psnr_filter3);
plot3Images(lena_gray_norm, lena_salt_pepper, lena_filter4, 'S&P Noise', ...
    '7x7 Gaussian Filter', psnr_gauss, psnr_filter4);
plot3Images(lena_gray_norm, lena_salt_pepper, lena_filter5, 'S&P Noise', ...
    '7x7 Averaging Filter', psnr_gauss, psnr_filter5);
plot3Images(lena_gray_norm, lena_salt_pepper, lena_filter6, 'S&P Noise', ...
    'Median Filter', psnr_gauss, psnr_filter6);
