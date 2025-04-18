%% Parcial Imágenes
% Nicolás González

clear all;
clc;

% Punto 1
function [imgGris, imgUmbral] = aplicarUmbral(image_path, umbral)
    
    imgJPG = imread(image_path); % Imagen original
    imgGris = rgb2gray(imgJPG); % Imagen escala de grises

    [m, n] = size(imgGris);
    imgUmbral = imgGris; % Imagen con el umbral

    % Umbral normalizado
    umbralPorcentaje = umbral * 255 / 100;

    % Aplicación umbral
    for i = 1:m
        for j = 1:n
            p = imgUmbral(i,j);
    
            if p < umbralPorcentaje
                imgUmbral(i, j) = 255;
            else
                imgUmbral(i, j) = 0;
            end
        end
    end
    
    % Gráfico
    figure(1)
    subplot(1,3,1), imshow(imgJPG), title('Img Original')
    subplot(1,3,2), imshow(imgGris), title('Escala de Grises')
    subplot(1,3,3), imshow(imgUmbral), title('Imagen con Umbral')
end

punto_1 = aplicarUmbral('prof.jpg', 40);