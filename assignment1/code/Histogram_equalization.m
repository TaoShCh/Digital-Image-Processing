function [output] = Histogram_equalization(input_image)
%first test the image is a RGB or gray image
if numel(size(input_image)) == 3
    %this is a RGB image
    %here is just one method, if you have other ways to do the
    %equalization, you can change the following code
    hsv = rgb2hsv(input_image);
    h=hsv(:,:,1);
    s=hsv(:,:,2);
    v=hsv(:,:,3);
    %s1 = rgb_hist_equal(s);
    v1 = rgb_hist_equal(v);
    [rgb] = hsv2rgb(h,s,v1);
    output = rgb;
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
    %{
    cnt1 = zeros(1,256,'int32');
    for i = 1 : M
        for j = 1 : N
            cnt1(1,trans(i,j)+1) = cnt1(1,trans(i,j)+1)+1;
        end
    end
    figure, bar(cnt1);
    %}
    end

    function [output] = rgb_hist_equal(input_channel)
    %you should complete this sub-function
    [M,N] = size(input_channel);
    cnt = zeros(1,1001);
    for i = 1 : M
        for j = 1 : N
            cnt(1, int32(1000 * input_channel(i,j)) + 1) = cnt(1, int32(1000 * input_channel(i,j)) + 1) + 1;
        end
    end
    sum_table = zeros(1,1001);
    for i = 2 : 1001
        sum_table(1,i) = sum_table(1,i-1) + cnt(1,i);
    end
    for i = 1 : 1001
        sum_table(1,i) = sum_table(1,i) * 1000 / ( M * N);
    end
    trans = zeros(M,N,'double');
    for i = 1 : M
        for j = 1 : N
            tmp = sum_table(1,int32(1000 * input_channel(i,j)+1));
            trans(i,j) = tmp/1000;
        end
    end
    output = trans;
    end


end