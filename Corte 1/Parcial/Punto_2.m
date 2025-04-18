%% Parcial Imágenes
% Nicolás González

clear all;
close all;
clc;

% Punto 2

img = imread('Koala.jpg');

% RGB
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

imgGris = rgb2gray(img); % Escala de grises

% Modificación
[m, n] = size(imgGris);
imgModificada = imgGris;

for i = 1:m
    for j = 1:n
        if (imgGris(i, j) <= 50) || (imgGris(i, j) >= 200)
            imgModificada(i, j) = 100;
        end
    end
end

% Binarización
imgBin = imgGris;

for i = 1:m
    for j = 1:n
        p = imgBin(i,j);

        if p < 128
            imgBin(i, j) = 0;
        else
            imgBin(i, j) = 255;
        end
    end
end

% Animación de umbralización con 200 valores
figure(1)
for umbral = linspace(0, 1, 200)
    imgUmbralAnim = imbinarize(imgGris, umbral);
    imshow(imgUmbralAnim)
    title(['Umbral: ', num2str(umbral)])
    pause(0.05)
end

% Imagen binarizada invertida
imgBinInvertida = ~imgBin;

% Gráficos
figure(2)
subplot(2,3,1)
imshow(img)
title('Imagen Original')

subplot(2,3,2)
imshow(imgGris)
title('Escala de Grises')

subplot(2,3,3)
imshow(imgModificada)
title('Imagen Modificada')

subplot(2,3,4)
imshow(imgBin)
title('Imagen Binaria')

subplot(2,3,5)
imshow(imgBinInvertida)
title('Imagen Binaria Invertida')

% Histogramas
figure(3)
hold on;
histogram(R(:), 256, 'FaceColor', 'r', 'EdgeColor', 'none')
histogram(G(:), 256, 'FaceColor', 'g', 'EdgeColor', 'none')
histogram(B(:), 256, 'FaceColor', 'b', 'EdgeColor', 'none')
title('Histogramas RGB')
xlabel('Intensidad')
ylabel('Frecuencia')
hold off
