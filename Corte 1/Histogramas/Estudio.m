% Código Original
clc
im=imread('Koala.jpg');
im=rgb2gray(im);
[m,n]=size(im);
[nk,rk]=imhist(im);
aux=nk(length(rk));

% Modificaciones en el código

% maxf=max(nk); % Se encuentra la frecuencia Máxima
% nknorm=nk/maxf; % Normalización con la frecuencia Máxima

imBin = im; % Se guarda la imagen para Binarizar

for i = 1:m
    for j = 1:n
        pixel = imBin(i,j);

        if pixel < 191 % Umbral del 75% (0-191 -- 192-255)
            imBin(i, j) = 0;
        else
            imBin(i, j) = 255;
        end
    end
end

imshow(imBin)

% 1. Qué hace la línea 6?
% R/ Obtener la frecuencia (nk) de la intensidad (rk) 255.

% 2. El histograma está normalizado?
% R/ No.

% 3. Binarizar la imagen con un umbral del 75% del rango de intensidades.