clear all;
clc;
im  = imread('Koala.jpg');
imGris  = rgb2gray(im);
[m,n] = size(imGris);

imBin = imGris; % Se guarda la imagen para Binarizar

for i = 1:m
    for j = 1:n
        pixel = imBin(i,j);

        if pixel < 178 % Umbral del 70% (0-178 -- 179-255)
            imBin(i, j) = 0;
        else
            imBin(i, j) = 255;
        end
    end
end

figure(1)
subplot(1,3,1)
imshow(im)
title('Imagen Original')

subplot(1,3,2)
imshow(imGris)
title('Escala de Grises')

subplot(1,3,3)
imshow(imBin)
title('Umbral 70%')