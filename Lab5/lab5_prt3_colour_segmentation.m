clc; clear; close all;
fontSize = 12;

% Load peppers image, convert to the L*a*b* colour space
f = imread('peppers.png');
size(f)
C = makecform('srgb2lab');
im_lab = applycform(f,C);

% Reshape the a* and b* channels
ab = double(im_lab(:,:,2:3));
m = size(ab,1);
n = size(ab,2);
ab = reshape(ab,m*n,2);

% Classify the colour using k-means clustering
%K = 2;
%row = [55 200];
%col = [155 400];

K = 4;
row = [55 130 200 280];
col = [155 110 400 470];

% Convert (r,c) indexing to 1D linear indexing
idx = sub2ind([size(f,1) size(f,2)], row, col);

% Vectorize starting coordinates
for k = 1:K
    mu(k,:) = ab(idx(k),:);
end

cluster_idx = kmeans(ab,K,'Start',mu);

% Label each pixel according to k-means
pixel_labels = reshape(cluster_idx, m, n);
h = figure; imshow(pixel_labels, []);
title(['Image labeled by cluster index, K=',num2str(K)],'FontSize',fontSize);
colormap('jet');

% Output each segment with original image pixels
segment = f;

% Change label value (1,2,3, or 4) to show different segment
label = 4;

for i = 1:m-1
    for j = 1:n-1
        if(pixel_labels(i,j) ~= label)
            segment(i,j,1) = 0;
            segment(i,j,2) = 0;
            segment(i,j,3) = 0;
        end
    end
end

figure; imshow(segment, []);
title(['Segment pixel label = ', num2str(label)]);
