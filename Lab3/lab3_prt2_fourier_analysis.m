clear all; close all; clc;
fontSize = 12;

% Generate test image
f = zeros(256, 256);
f(:,108:148) = 1;

% Generate the Fourier spectra of the test image
X = fft2(f);
X_shift = fftshift(X);
X_log = log(1+abs(X_shift));

% Plot images
figure;
set(gcf, 'Position', get(0,'Screensize'));
subplot(1, 3, 1);
imshow(f); 
title('Test image', 'FontSize', fontSize);
subplot(1, 3, 2);
imshow(abs(X_shift), []); 
title('Test image Fourier spectra', 'FontSize', fontSize);
subplot(1, 3, 3);
imshow(abs(X_log), []);
title('Test image Fourier spectra, log', 'FontSize', fontSize);

% Rotate the image and plot the Fourier spectra
f_rotate = imrotate(f, 45); 
Y = fft2(f_rotate);
Y_shift = fftshift(Y);
Y_log = log(1+abs(Y_shift));

% Plot rotated images
figure;
set(gcf, 'Position', get(0,'Screensize'));
subplot(1, 3, 1);
imshow(f_rotate); 
title('Rotated test image', 'FontSize', fontSize);
subplot(1, 3, 2);
imshow(abs(Y_shift), []);
title('Rotated image Fourier spectra', 'FontSize', fontSize);
subplot(1, 3, 3);
imshow(abs(Y_log), []);
title('Rotated image Fourier spectra, log', 'FontSize', fontSize);

% Amplitude and phase analysis
lena = imread('lena.tiff');
lena_gray = convert2grayscale(lena);
lena_fft = fft2(lena_gray);
lena_amplitude = abs(lena_fft);
lena_phase = lena_fft./lena_amplitude;
lena_amplitude_inv = log(ifft2(lena_amplitude));
lena_phase_inv = ifft2(lena_phase);

% Plot images
figure;
set(gcf, 'Position', get(0,'Screensize'));
subplot(1, 3, 1);
imshow(lena_gray); 
title('Original gray image', 'FontSize', fontSize);
subplot(1, 3, 2);
imshow(lena_amplitude_inv, []);
title('Inverse Fourier transform of amplitude', 'FontSize', fontSize);
subplot(1, 3, 3);
imshow(lena_phase_inv, []);
title('Inverse Fourier transform of phase', 'FontSize', fontSize);
