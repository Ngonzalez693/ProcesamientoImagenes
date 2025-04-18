clear all;
clc;
close all;
i=imread('Koala.jpg');
grises=rgb2gray(i);
[m,n]=size(grises);
tam=m*n; %Se obtiene el tamaño de la matriz
J = histeq(grises);
imshowpair(grises,J,'montage')
axis off
figure
imhist(grises,64);
figure
imhist(J,64);