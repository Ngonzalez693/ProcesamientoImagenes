close all
clear all
clc

ht= 40;
w= 200;

I=zeros(ht,w,3);

% Margen amarilla
I(1:ht, 1:w, 1) = 255;
I(1:ht, 1:w, 2) = 255;
I(1:ht, 1:w, 3) = 0;

% Rectángulo gris
I(6:ht-5, 6:60 , 1)= 205;
I(6:ht-5, 6:60 , 2)= 205;
I(6:ht-5, 6:60 , 3)= 205;

% Rectángulo morado
I(6:ht-5, 71:139, 1)= 87;
I(6:ht-5, 71:139, 2)= 35;
I(6:ht-5, 71:139, 3)= 100;

% Rectángulo verde lima
I(6:ht-5, 150:w-5, 1) = 57;
I(6:ht-5, 150:w-5, 2) = 255;
I(6:ht-5, 150:w-5, 3) = 20;

h1=figure(1)
I = uint8(I)
imshow(I)