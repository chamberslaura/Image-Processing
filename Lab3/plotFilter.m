function [] = plotFilter(filter, type)
    fontSize = 12;    
    figure;
    colormap(gray);
    imagesc(filter);
    title(type, 'FontSize', fontSize);
end

