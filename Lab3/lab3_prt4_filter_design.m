clear all; close all; clc;
fontSize = 12;

% Load image
f = imread('frequnoisy.tif');

% Generate the Fourier spectrum of the original image
F = fft2(f);
F_sh = fftshift(F);
F_sh_log = log(abs(F_sh));

% Design notch filter to cancel out bright peaks in the Fourier spectrum
maxVal = max(F_sh_log,[],'all');
threshold = maxVal - 5;
H = F_sh_log >= threshold;
figure(1);
imshow(H, []); title('Filter design in progress', 'FontSize', fontSize);
H(100:150, 110:150) = 0;
J = imcomplement(H);

% Apply filter to original image
G_sh = F_sh.*J;
G = ifftshift(G_sh);
g = real(ifft2(G));

% Plot images and spectra
figure(2);
imshow(f); title('Original image', 'FontSize', fontSize);
figure(3);
imshow(F_sh_log, []); title('Fourier spectrum', 'FontSize', fontSize);
figure(4);
imshow(H, []); title('Inverted notch filter', 'FontSize', fontSize);
figure(5);
imshow(J, []); title('Notch filter', 'FontSize', fontSize);
figure(6);
imshow(log(abs(G_sh)), []); title('Filtered Fourier spectrum',...
    'FontSize', fontSize);
figure(7);
imshow(g, []); title('Filtered image', 'FontSize', fontSize);
