clear all;
clc;

% matriz de la imagen en escala de grises
image = [ 
    12  104  54  75  1;
    87  201  153  89  12;
    23  57  49  38  47;
    205  198  157  53  39;
    28  14  7  5  1
];

% Convertir la matriz en un vector
pixels = image(:);

% Dibujar el histograma
figure(1)
histogram(pixels, 256, 'BinLimits', [0, 255], 'FaceColor', 'b', 'EdgeColor', 'k')
xlabel('Intensidad de píxeles')
ylabel('Frecuencia')
title('Histograma de la imagen en escala de grises')
grid on
