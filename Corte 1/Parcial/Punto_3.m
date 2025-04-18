%% Parcial Imágenes
% Nicolás González

clear all;
close all;
clc;

% Punto 3

% Se genera una imagen con la IA Copilot en formato Jpeg a una calidad del
% 90%
img = imread('Figuras.jpeg');

% Cálculo del tamaño del archivo en KB
fileInfo = dir('Figuras.jpeg');
fileSizeKB = fileInfo.bytes / 1024; % Convertir a KB

% Cálculo del tamaño teórico (24 bits por píxel)
[m, n, c] = size(img);
bits = 24;
fileSizeTeoricoKB = (m * n * bits) / (8 * 1024); % KB

% Filtro (Blur)
imgBlur = imgaussfilt(img, 30); % Desenfoque
imwrite(imgBlur, 'Figuras_Suavizada.jpg'); % Se guarda la imagen con el filtro

% Comparación de tamaños
fileInfoBlur = dir('Figuras_Suavizada.jpg');
fileSizeBlurKB = fileInfoBlur.bytes / 1024; % Convertir a KB

% Histogramas de la imagen original y suavizada
imgGris = rgb2gray(img);
imgBlurGris = rgb2gray(imgBlur);

% Grafico histogramas
figure('Name', 'Histogramas de Intensidad');
subplot(1,2,1);
imhist(imgGris);
title('Histograma de la Imagen Original');
xlabel('Intensidad');
ylabel('Frecuencia');

subplot(1,2,2);
imhist(imgBlurGris);
title('Histograma de la Imagen Suavizada');
xlabel('Intensidad');
ylabel('Frecuencia');

% Mostrar resultados en consola
fprintf('Tamaño original: %.2f KB\n', fileSizeKB);
fprintf('Tamaño teórico sin compresión: %.2f KB\n', fileSizeTeoricoKB);
fprintf('Tamaño después del suavizado: %.2f KB\n', fileSizeBlurKB);

% Imagen original: En el histograma se ven unos picos definidos en algunas
% intensidades, por lo que tiene datos predominantes.

% Imagen suavizada: En el histograma se distribuyan más los valores de
% intensidad, hay un aumento al final por lo que tiene más blancos. También
% hay una mayor presencia de tonos intermedios.