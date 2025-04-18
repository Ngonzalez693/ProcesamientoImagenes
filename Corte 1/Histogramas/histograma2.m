clear all;
clc;
close all;

i=imread('koala.jpg');
grises=rgb2gray(i);
[nk,rk]=imhist(grises);
tam1=numel(grises);
[m,n]=size(grises);
tam2=m*n;
rk1=nk./numel(grises);
suma=cumsum(rk1);
rk2=suma*256;
% subplot(2,1,1)
% bar(rk,nk,0.2);
% subplot(2,1,2)
% bar(rk2,nk,20);
J = histeq(grises);
subplot(2,2,1)
imshow(grises);
subplot(2,2,2)
imshow(J);
subplot(2,2,3);
imhist(grises,64);
subplot(2,2,4);
imhist(J,64);