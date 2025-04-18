close all;
clear all;
clc;

% Dimensiones
ht = 40; 
w = 60;  
sep = 10;
wt = 3 * w + 2 * sep;
margin = 5;

margen_ht = ht + 2 * margin;
margen_wt = wt + 2 * margin;

% Crear imagen con márgenes
I = zeros(margen_ht, margen_wt, 3);

% Posiciones de las columnas
x1 = margin + 1;
x2 = x1 + w + sep;
x3 = x2 + w + sep;

y1 = margin + 1;
y2 = y1 + ht - 1;

% Rectángulo marrón
I(y1:y2, x1:x1+w-1, 1) = 128; 
I(y1:y2, x1:x1+w-1, 2) = 64;
I(y1:y2, x1:x1+w-1, 3) = 0;

% Rectángulo amarillo
I(y1:y2, x2:x2+w-1, 1) = 255;
I(y1:y2, x2:x2+w-1, 2) = 255;
I(y1:y2, x2:x2+w-1, 3) = 0;

I(y1:y2, x3:x3+w-1, 1) = 255; 
I(y1:y2, x3:x3+w-1, 2) = 128;
I(y1:y2, x3:x3+w-1, 3) = 0;

h1 = figure(1)
imshow(uint8(I))