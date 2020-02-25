function output = my_edge(input_image)
%in this function, you should finish the edge detection utility.
%the input parameter is a matrix of a gray image
%the output parameter is a matrix contains the edge index using 0 and 1
%the entries with 1 in the matrix shows that point is on the edge of the
%image
%you can use different methods to complete the edge detection function
%the better the final result and the more methods you have used, you will get higher scores 
[m,n] = size(input_image);
h = fspecial('sobel');
img_h = imfilter(input_image, h, 'replicate');
h = h';
img_w = imfilter(input_image, h, 'replicate');
img = sqrt(img_h .^ 2 + img_w .^ 2);

high = 0.8; low = 0.3;
for i = 2 : m - 1
    for j = 2 : n - 1
        if(img_w(i,j) == 0)
            theta = sign(img_h(i,j)) * 90;
        else
            theta = atand(img_h(i,j) / img_w(i,j) );
        end
        if(abs(theta) >= 67.5)
            m1 = img(i - 1,j);
            m2 = img(i + 1,j);
        elseif(theta >= -67.5 && theta <= -22.5)
            m1 = img(i - 1,j - 1);
            m2 = img(i + 1,j + 1);
        elseif(theta >= -22.5 && theta <= 22.5)
            m1 = img(i, j - 1);
            m2 = img(i, j + 1);
        elseif(theta >= 22.5 && theta <= 67.5)
            m1 = img(i + 1, j - 1);
            m2 = img(i - 1, j + 1);
        end
        if(img(i, j) <= m1 || img(i, j) <= m2)
            img(i, j) = 0;
        end
        
        if(img(i,j) < low)
            img(i,j) = 0;
        end
    end
end

for i = 2 : m - 1
    for j = 2 : n - 1
        if(img(i,j) >= high)
            neighbour = img(i-1:i+1, j-1:j+1);
            for ii = 1 : 3
                for jj = 1 : 3
                    if(neighbour(ii,jj) > low && neighbour(ii,jj) < high)
                        img(i+ii-2, j+jj-2) = high;
                    end
                end
            end         
        end
    end
end

for i = 2 : m - 1
    for j = 2 : n - 1
        if(img(i,j) < high)
            img(i,j) = 0;
        end
    end
end

output = img;


