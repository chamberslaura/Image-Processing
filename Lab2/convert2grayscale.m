function image_gray = convert2grayscale(image)
% Check if the image is colour and convert to grayscale if it is
    [m, n, numberOfColorChannels] = size(image);
    if numberOfColorChannels > 1
        % If it's a colour image, convert to gray
        image_gray = rgb2gray(image);
    else
        % Already gray, don't convert
        image_gray = image;
end

