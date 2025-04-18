clear all;
clc;
imagen  = imread('Koala.jpg');
imGris  = rgb2gray(imagen);
[m,n] = size(imGris);
umbral= 80;

for i=1:m
    for j=1:n
        if imGris(i,j)<80
            imBN(i,j)=0;

        else
            imBN(i,j)=255;
        end


    end

end




% Grafico
subplot(3,1,1)
imshow(imagen);
subplot(3,1,2)
imshow(imGris);
subplot(3,1,3)
imshow(imBN);