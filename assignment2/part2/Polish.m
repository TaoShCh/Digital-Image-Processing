function [output] = Polish(image)
    I = image;
    sigma = 100;
    gausFilter = fspecial('gaussian', [5,5], sigma);
    output = imfilter(I, gausFilter, 'replicate');
end
