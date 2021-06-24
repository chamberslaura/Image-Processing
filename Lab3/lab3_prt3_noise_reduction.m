clear all; close all; clc;
fontSize = 12;

% Load images, convert to grayscale, and normalize intensities
lena = imread('lena.tiff');
lena_gray = convert2grayscale(lena);
f1 = double(lena_gray)/255;

% Add noise to lena_gray_norm
f2 = imnoise(f1,'gaussian',0,0.005);
psnr1 = PSNR_norm(f1,f2);

% Generate the Fourier spectra of the images
F1 = fft2(f1);
F1_sh = fftshift(F1);
F1_sh_log = log(1+abs(F1_sh));

F2 = fft2(f2);
F2_sh = fftshift(F2);
F2_sh_log = log(1+abs(F2_sh));

% Plot images
figure;
set(gcf, 'Position', get(0,'Screensize'));
subplot(2, 2, 1);
imshow(f1); 
title('Original gray image', 'FontSize', fontSize);
subplot(2, 2, 3);
imshow(f2, []);
title('Image with Gaussian noise', 'FontSize', fontSize);
subplot(2, 2, 2);
imshow(F1_sh_log, []);
title('Original image Fourier spectra', 'FontSize', fontSize);
subplot(2, 2, 4);
imshow(F2_sh_log, []);
title('Noisy image Fourier spectra', 'FontSize', fontSize);
txt = strcat('PSNR = ', sprintf('%.2f',psnr1));
annotation('textbox', [0.25, 0, 0.1, 0.1], 'string', txt);

% LOW-PASS FILTER
% Create ideal low-pass filter with r = 60
r = 60;
[M N] = size(f1);
h60 = fspecial('disk',r); h60(h60 > 0) = 1;
H60 = zeros(M,N);
H60(M/2-r:M/2+r,N/2-r:N/2+r) = h60;

% Apply filter to image and plot
G60_sh = F2_sh.*H60;
G60 = ifftshift(G60_sh);
g60 = real(ifft2(G60));
psnr2 = PSNR_norm(f1,g60);

figure;
imshow(g60);
title('Filtered image, r = 60', 'FontSize', fontSize);
txt = strcat('PSNR = ', sprintf('%.2f',psnr2));
annotation('textbox', [0.4, 0, 0.1, 0.1], 'string', txt);

% Create ideal low-pass filter with r = 20
r = 20;
h20 = fspecial('disk',r); h20(h20 > 0) = 1;
H20 = zeros(M,N);
H20(M/2-r:M/2+r,N/2-r:N/2+r) = h20;

% Apply filter to image and plot
G20_sh = F2_sh.*H20;
G20 = ifftshift(G20_sh);
g20 = real(ifft2(G20));
psnr2 = PSNR_norm(f1,g20);

figure;
imshow(g20);
title('Filtered image, r = 20', 'FontSize', fontSize);
txt = strcat('PSNR = ', sprintf('%.2f',psnr2));
annotation('textbox', [0.4, 0, 0.1, 0.1], 'string', txt);

% GAUSSIAN FILTER
% Create Gaussian filter
H_gauss = double(fspecial('gaussian', [M N], 60));
H = H_gauss./max(H_gauss,[],'all');
plotFilter(H, 'Gaussian low-pass filter');

% Apply filter to image and plot
G_sh = F2_sh.*H;
G = ifftshift(G_sh);
g = real(ifft2(G));
psnr3 = PSNR_norm(f1,g);

figure;
imshow(g);
title('Filtered image, Gaussian', 'FontSize', fontSize);
txt = strcat('PSNR = ', sprintf('%.2f',psnr3));
annotation('textbox', [0.4, 0, 0.1, 0.1], 'string', txt);