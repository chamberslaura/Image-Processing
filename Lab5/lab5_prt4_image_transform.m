clc; clear; close all;
fontSize = 12;

% Load Lena image
lena = imread('lena3.tiff');
f = double(rgb2gray(lena));

% Construct and plot DCT transform matrix
T = dctmtx(8);
figure(1); imshow(imresize(T,20,'nearest'), []);

% Apply the DCT transformation
F_trans = floor(blkproc(f-128,[8 8],'P1*x*P2',T,T'));
sub1 = F_trans(81:81+7,297:297+7);
sub2 = F_trans(1:8,1:8);
figure(2); imshow(imresize(abs(sub1),20,'nearest'),[]); title('(81,297)');
figure(3); imshow(imresize(abs(sub2),20,'nearest'),[]); title('(1,1)');

% Discard all but 6 of the DCT coefficients and reconstruct image
mask = zeros(8,8);
mask(1,1) = 1;
mask(1,2) = 1;
mask(1,3) = 1;
mask(2,1) = 1;
mask(3,1) = 1;
mask(2,2) = 1;
F_thresh = blkproc(F_trans, [8 8], 'P1.*x', mask); 
f_thresh = floor(blkproc(F_thresh, [8 8], 'P1*x*P2', T', T)) + 128;

% Plot original and reconstructed images and PSNR
figure(4); imshow(f,[]); title('Original','FontSize', fontSize);
figure(5); imshow(f_thresh,[]); title('Reconstructed','FontSize', fontSize);
psnr = PSNR_norm(f,f_thresh);
txt = strcat('PSNR = ', sprintf('%.2f',psnr));
annotation('textbox', [0.4, 0, 0.1, 0.1], 'string', txt);