function output = my_edgelinking(binary_image, row, col)
%in this function, you should finish the edge linking utility.
%the input parameters are a matrix of a binary image containing the edge
%information and coordinates of one of the edge points of a obeject
%boundary, you should run this function multiple times to find different
%object boundaries
%the output parameter is a Q-by-2 matrix, where Q is the number of boundary 
%pixels. B holds the row and column coordinates of the boundary pixels.
%you can use different methods to complete the edge linking function
%the better the quality of object boundary and the more the object boundaries, you will get higher scores 
output = [row, col];
now_r = row; now_c = col; 
now_direct = 0; flag = 1; begin =1;
dir = [2,0;1,0;2,1;2,-1;1,-1;1,1;2,2;2,-2;  0,-2;0,-1;1,-2;-1,-2;1,-1;-1,-1;2,-2;-2,-2; -2,0;-1,0;-2,1;-2,-1;-1,1;-1,-1;-2,2;-2,-2;  0,2;0,1;1,2;-1,2;1,1;1,-1;2,2;-2,2];

while(begin || (flag && (now_r ~= row || now_c ~= col)))
    begin = 0;
    for j = 1 : 32
        i = mod(8 * now_direct + j, 32);
        if(i == 0)
            i = 32;
        end
        r = now_r + dir(i,1);
        c = now_c + dir(i,2);
        x = ismember([r,c],output, 'rows');
        if(max(x) > 0)
            continue;
        end
        if(binary_image(r,c) >= 0.8)
            now_r = r;
            now_c = c;
            output = [output;[r,c]];
            now_direct = floor((i - 1) / 8);
            break;
        end
        if(j == 32)
            flag = 0;
        end
    end
end



