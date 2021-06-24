function [] = plot3Images(f,g,h, title1, title2, psnr1, psnr2)
    fontSize = 12;
    figure;
    set(gcf, 'Position', get(0,'Screensize'));
    subplot(2, 3, 1);
    imshow(f);
    title('Original', 'FontSize', fontSize);
    subplot(2, 3, 4);
    imhist(f);
    subplot(2, 3, 2);
    imshow(g);
    title(title1, 'FontSize', fontSize);
    subplot(2, 3, 5);
    imhist(g);
    subplot(2, 3, 3);
    imshow(h);
    title(title2, 'FontSize', fontSize);
    subplot(2, 3, 6);
    imhist(h);
    txt = strcat('PSNR = ', sprintf('%.2f',psnr1));
    annotation('textbox', [0.48, 0.45, 0.1, 0.1], 'string', txt);
    txt = strcat('PSNR = ', sprintf('%.2f',psnr2));
    annotation('textbox', [0.76, 0.45, 0.1, 0.1], 'string', txt);
end

