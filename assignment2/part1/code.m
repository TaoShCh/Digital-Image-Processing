Image = imread('test1.jpg');
if numel(size(Image)) == 3
    I = rgb2gray(Image);
else
    I = Image;
end
I = double(I);
[M,N] = size(I);
sobel = zeros(M, N);
for i = 2 : M - 1
    for j = 2 : N - 1
        Gx = I(i+1,j-1)+2*I(i+1,j)+I(i+1,j+1)-I(i-1,j-1)-2*I(i-1,j)-I(i-1,j+1);
        Gy = I(i-1,j+1)+2*I(i,j+1)+I(i+1,j+1)-I(i-1,j-1)-2*I(i,j-1)-I(i+1,j-1);
        sobel(i,j) = sqrt(Gx^2 + Gy^2);
    end
end
subplot(2,2,1), imshow(sobel,[]), title('ø’º‰”Ú¬À≤®');

P = 2 * M;
Q = 2 * N;
fp = zeros(P,Q);
fp(1:M,1:N) = I(1:M,1:N);
for i = 1 : M
    for j = 1 : N 
        fp(i,j) = double(fp(i,j)*(-1)^(i+j));
    end
end
F = fft2(fp,P,Q);

H1 = zeros(P,Q);
H2 = zeros(P,Q);
H1(M - 1,N - 1) = -1; H1(M,N - 1) = -2; H1(M + 1,N - 1) = -1;
H1(M - 1,N + 1) = 1; H1(M,N + 1) = 2; H1(M + 1,N + 1) = 1;
Hx = fft2(H1);
Hx = fftshift(log(1 + abs(Hx)));
subplot(2,2,3),imshow(Hx,[]), title('À„◊”∆µ”Ú');
H2(M - 1, N - 1) = -1; H2(M - 1, N) = -2; H2(M - 1, N + 1) = -1;
H2(M + 1, N - 1) = 1; H2(M + 1, N) = 2; H2(M + 1, N + 1) = 1;
Hy = fft2(H2);
Hy = fftshift(log(1 + abs(Hy)));
subplot(2,2,4),imshow(Hy,[]), title('À„◊”∆µ”Ú');
G1 = Hx .* F;
G2 = Hy .* F;
new_image1 = real(ifft2(G1));
new_image2 = real(ifft2(G2));
new_image = zeros(M,N);
for i = 1 : M
    for j = 1 : N 
        x = new_image1(i,j);
        y = new_image2(i,j);
        new_image(i,j) = double(sqrt(x^2 + y^2));
    end
end
output(1:M,1:N) = new_image(1:M,1:N);
subplot(2,2,2), imshow(output,[]), title('∆µ¬ ”Ú¬À≤®');

originF = fft2(I);
originF = fftshift(log(1 + abs(originF)));
figure,imshow(originF,[]), title('‘≠Õº∆µ”Ú');



