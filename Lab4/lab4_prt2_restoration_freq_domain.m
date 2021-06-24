clear all; close all; clc;
fontSize = 12;

% Load image
f = im2double(imread('cameraman.tif'));

% Create blurred image
h = fspecial('disk',4);
h_freq = fft2(h, size(f,1), size(f,2)); %pad h
figure(5); imshow(real(fftshift(h_freq)));
f_blur = real(ifft2(h_freq.*fft2(f)));
psnr1 = PSNR_norm(f, f_blur);

% Apply inverse filtering
f_blur_inv = real(ifft2(fft2(f_blur)./h_freq));
psnr2 = PSNR_norm(f, f_blur_inv);

% Add zero-mean Gaussian noise to the blurred image
f_blur_n = imnoise(f_blur,'gaussian',0,0.002);
f_blur_n_inv = real(ifft2(fft2(f_blur_n)./h_freq));
psnr3 = PSNR_norm(f, f_blur_n_inv);

% Apply Wiener filter to the noisy blurred image
f_wiener = deconvwnr(f_blur_n, h, 0.15);
psnr4 = PSNR_norm(f, f_wiener);

% Plot images - question 1
figure(1);
subplot(1, 3, 1);
imshow(f);
title('Original Image', 'FontSize', fontSize);
subplot(1, 3, 2);
imshow(f_blur, []);
title('Blurred Image', 'FontSize', fontSize);
txt = strcat('PSNR = ', sprintf('%.2f',psnr1));
annotation('textbox', [0.47, 0.1, 0.1, 0.1], 'string', txt);
subplot(1, 3, 3);
imshow(f_blur_inv, []);
title('Inverse Filtered Image', 'FontSize', fontSize);
txt = strcat('PSNR = ', sprintf('%.2f',psnr2));
annotation('textbox', [0.75, 0.1, 0.1, 0.1], 'string', txt);

% Plot images - questions 2, 3
figure(2);
subplot(1, 2, 1);
imshow(f_blur_inv, []);
title('Inverse Filtered Image', 'FontSize', fontSize);
txt = strcat('PSNR = ', sprintf('%.2f',psnr2));
annotation('textbox', [0.22, 0.1, 0.1, 0.1], 'string', txt);
subplot(1, 2, 2);
imshow(f_blur_n_inv, []);
title('Inv Filtered Image, Noise', 'FontSize', fontSize);
txt = strcat('PSNR = ', sprintf('%.2f',psnr3));
annotation('textbox', [0.67, 0.1, 0.1, 0.1], 'string', txt);

% Plot images - questions 4, 5
figure(3);
subplot(1, 2, 1);
imshow(f_blur_n_inv, []);
title('Inv Filtered Image, Noise', 'FontSize', fontSize);
txt = strcat('PSNR = ', sprintf('%.2f',psnr3));
annotation('textbox', [0.22, 0.1, 0.1, 0.1], 'string', txt);
subplot(1, 2, 2);
imshow(f_wiener, []);
title('Wiener Filtered Image', 'FontSize', fontSize);
txt = strcat('PSNR = ', sprintf('%.2f',psnr4));
annotation('textbox', [0.67, 0.1, 0.1, 0.1], 'string', txt);

