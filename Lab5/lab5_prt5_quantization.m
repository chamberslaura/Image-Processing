clc; clear; close all;
fontSize = 12;

% Load Lena image
lena = imread('lena3.tiff');
f = double(rgb2gray(lena));

% Construct quantization matrix (change multiple to 1, 3, 5, 10)
multiple = 1;
Z = multiple.*[16 11 10 16 24 40 51 61;
               12 12 14 19 26 58 60 55;
               14 13 16 24 40 57 69 56;
               14 17 22 29 51 87 80 62;
               18 22 37 56 68 109 103 77;
               24 35 55 64 81 104 113 92;
               49 64 78 87 103 121 120 101;
               72 92 95 98 112 100 103 99];
 
% Construct and plot DCT transform matrix
T = dctmtx(8);

% Apply the DCT transformation
F_trans = floor(blkproc(f-128,[8 8],'P1*x*P2',T,T'));

% Perform quantization and calculate PSNR
fun1 = @(block_struct) round(double(block_struct) ./ Z);
F_quant = blkproc(F_trans,[8 8],fun1);

%Reconstruct the image and calculate PSNR
fun2 = @(block_struct) T'*(block_struct .* Z)*T;
f_recon = blkproc(F_quant, [8 8], fun2) + 128;
psnr = PSNR_norm(f,f_recon);

% Plot reconstructed image
figure; imshow(f_recon,[]); 
title(['Reconstructed Image, ', num2str(multiple), 'Z']);
txt = strcat('PSNR = ', sprintf('%.2f',psnr));
annotation('textbox', [0.4, 0, 0.1, 0.1], 'string', txt);
