clear all;
clc;
imagen  = imread('Koala.jpg'); % Lee la imagen
imGris  = rgb2gray(imagen); % Convierte la imagen a escala de grises
[m,n] = size(imGris);

imBN = imGris;

for i = 1:m
    for j = 1:n
        pixel = imBN(i,j);

        if pixel < 100
            imBN(i, j) = 0;
        else
            imBN(i, j) = 255;
        end
    end
end

% Gráfico
subplot(1,3,1)
imshow(imagen);

subplot(1,3,2)
imshow(imGris);

subplot(1,3,3)
imshow(imBN);

% uint8 : Números enteros positivos del 0 - 255
% 768 x 1024 x 3 (3 canales, RGB)
% rgb2gray : Se pasa de 3 matrices a 1 sola matriz
% el size() guarda el tamaño en las variables [m,n]