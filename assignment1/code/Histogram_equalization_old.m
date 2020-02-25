function [output] = Histogram_equalization(input_image)
%first test the image is a RGB or gray image
if numel(size(input_image)) == 3
    %this is a RGB image
    %here is just one method, if you have other ways to do the
    %equalization, you can change the following code
    r=input_image(:,:,1);
    v=input_image(:,:,2);
    b=input_image(:,:,3);
    r1 = hist_equal(r);
    v1 = hist_equal(v);
    b1 = hist_equal(b);
    output = cat(3,r1,v1,b1);    
else
    %this is a gray image
    [output] = hist_equal(input_image);
    
end

    function [output] = hist_equal(input_channel)
    %you should complete this sub-function
    [M,N] = size(input_channel);
    cnt = zeros(1,256);
    for i = 1 : M
        for j = 1 : N
            cnt(1, input_channel(i,j) + 1) = cnt(1, input_channel(i,j) + 1) + 1;
        end
    end
    sum_table = zeros(1,256);
    for i = 2 : 256
        sum_table(1,i) = sum_table(1,i-1) + cnt(1,i);
    end
    for i = 1 : 256
        sum_table(1,i) = sum_table(1,i) * 256 / ( M * N);
    end
    trans = zeros(M,N,'uint8');
    for i = 1 : M
        for j = 1 : N
            tmp = sum_table(1,input_channel(i,j) + 1);
            trans(i,j) = uint8(tmp);
        end
    end
    output = trans;

    end
end