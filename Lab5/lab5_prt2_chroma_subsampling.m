clc; clear; close all;
fontSize = 12;

% Load peppers image, convert to YCbCr, and plot both
RGB = imread('peppers.png');
YCbCr = rgb2ycbcr(RGB);
figure(1); imshow(RGB); title('Original', 'FontSize', fontSize);
figure(2); imshow(YCbCr); title('YCbCr', 'FontSize', fontSize);

% Plot Y, Cb, and Cr channels separately
Y = YCbCr(:,:,1);
Cb = YCbCr(:,:,2);
Cr = YCbCr(:,:,3);
figure(3); imshow(Y); title('Y Channel', 'FontSize', fontSize);
figure(4); imshow(Cb); title('Cb Channel', 'FontSize', fontSize);
figure(5); imshow(Cr); title('Cr Channel', 'FontSize', fontSize);

% Reduce resolution of chroma channels by factor of 2
Cb_down = imresize(Cb, 1/2);
Cr_down = imresize(Cr, 1/2);

% Upsample chroma channels to original resolution
Cb_up = imresize(Cb_down, 2, 'bilinear');
Cr_up = imresize(Cr_down, 2, 'bilinear');

% Recombine Y, Cb, and Cr channels
YCbCr_recombined1 = cat(3, Y, Cb_up, Cr_up);
RGB_recombined1 = ycbcr2rgb(YCbCr_recombined1);
figure(6); imshow(YCbCr_recombined1); 
title('Recombined YCbCr (Chroma Sampling)','FontSize', fontSize); 
figure(7); imshow(RGB_recombined1); 
title('Recombined RGB (Chroma Sampling)','FontSize', fontSize); 

% Reduce resolution of Y channel by factor of 2
Y_down = imresize(Y, 1/2);

% Upsample Y channel to original resolution
Y_up = imresize(Y_down, 2, 'bilinear');

% Recombine Y, Cb, and Cr channels
YCbCr_recombined2 = cat(3, Y_up, Cb, Cr);
RGB_recombined2 = ycbcr2rgb(YCbCr_recombined2);
figure(8); imshow(YCbCr_recombined2); 
title('Recombined YCbCr (Y Sampling)','FontSize',fontSize); 
figure(9); imshow(RGB_recombined2); 
title('Recombined RGB (Y Sampling)','FontSize',fontSize); 
