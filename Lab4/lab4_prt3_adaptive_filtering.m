clear all; close all; clc;
fontSize = 12;

% Load degraded image
g = im2double(imread('degraded.tif'));

% Find variance of noise in degraded image
f = im2double(imread('cameraman.tif'));
I = f(25:65, 1:40); %flat region of degraded image
J = g(25:65, 1:40); %same region of undegraded image
noise_only = J - I
noise_var = var(J(:));

% Construct and apply Lee filter with different noise variances
% and window sizes
f_hat_1 = lee_filter(g, noise_var, 5)
f_hat_2 = lee_filter(g, 0.5*noise_var, 5);
f_hat_3 = lee_filter(g, 3*noise_var, 5);
f_hat_4 = lee_filter(g, noise_var, 3);
f_hat_5 = lee_filter(g, noise_var, 11);

% Generate and apply Gaussian filter
[M N] = size(g);
H_gauss = double(fspecial('gaussian', [M N], 120));
H = H_gauss./max(H_gauss,[],'all');
g_gauss = real(ifft2(H_gauss.*fft2(g)));

% Plot images
% Question 6
figure(1);
subplot(1,2,1);
imshow(f);
title('Original Image', 'FontSize', fontSize);
subplot(1,2,2);
imshow(g);
title('Degraded Image', 'FontSize', fontSize);

% Question 7
figure(2); 
subplot(1,3,1);
imshow(g);
title('Degraded Image', 'FontSize', fontSize);
subplot(1,3,2);
imshow(f_hat_1);
title('Lee Filter', 'FontSize', fontSize);
subplot(1,3,3);
imshow(g_gauss, []);
title('Gaussian Low Pass Filter', 'FontSize', fontSize);

% Question 8
figure(3);
subplot(1,3,1);
imshow(f_hat_1);
title('1 x Noise Variance', 'FontSize', fontSize);
subplot(1,3,2);
imshow(f_hat_2);
title('0.5 x Noise Variance', 'FontSize', fontSize);
subplot(1,3,3);
imshow(f_hat_3);
title('3 x Noise Variance', 'FontSize', fontSize);

% Question 9
figure(4);
subplot(1,3,1);
imshow(f_hat_1);
title('5x5 Window Size', 'FontSize', fontSize);
subplot(1,3,2);
imshow(f_hat_4);
title('3x3 Window Size', 'FontSize', fontSize);
subplot(1,3,3);
imshow(f_hat_5);
title('11x11 Window Size', 'FontSize', fontSize);