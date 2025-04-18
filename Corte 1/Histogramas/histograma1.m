clear all;
clc;
close all;

i=imread('Koala.jpg');
% subplot(1,3,1)
% imshow(i);
grises=rgb2gray(i);
[m,n]=size(grises);
tam=m*n; %Se obtiene el tamaño de la matriz
% subplot(1,4,1)
% imshow(grises);
% byn=im2bw(grises);
% subplot(1,3,3)
% imshow(byn);
[nk1,rk]=imhist(grises);  %nk->Frecuencias    rk->Intensidas
%bar(rk,nk1,1);
nk1normmet1=nk1/tam;   %normalizar el vector de frecuencias
% subplot(1,2,1);
% bar(rk,nk1,1);
% subplot(1,2,2);
% bar(rk,nk1normmet1,1);

% normalizar por la frecuencia máxima
maxf=max(nk1);
nk1normmet2=nk1/maxf;

subplot(1,4,1);
bar(rk,nk1,1);
subplot(1,4,2);
bar(rk,nk1normmet1,1);
subplot(1,4,3);
bar(rk,nk1normmet2,1);

%%%%%%%%%%%%%%%%%%%%%%% Ecualizar
rk1=nk1/numel(grises);
suma=cumsum(rk1); % Sumatoria ---> cumsum()
rk2=suma*256;
subplot(1,4,4);
bar(rk2,nk1,1);

%%%%%%%%%%%%%%%%%%%%%
% subplot(2,2,1)
% imshow(grises);
% 
% subplot(2,2,2)
% imhist(grises);
% 
% griseshisteq= histeq(grises);
% 
% subplot(2,2,3);
% imshow(griseshisteq);
% 
% subplot(2,2,4);
% imhist(griseshisteq,64);

%%%%%%%%%%%%%%%%%%%%%
% griseshisteq= histeq(grises);
% subplot(1,3,3);
% imhist(griseshisteq,64);

% imshow(griseshisteq);

% subplot(1,4,2)
% bar(rk,nk1,1);
% subplot(1,4,3)
% bar(rk,nk1normmet1,1);
% subplot(1,4,4)
% bar(rk,nk1normmet2,1);


% rk1=nk1./numel(grises);
% suma=cumsum(rk1);
% rk2=suma.*256;
% subplot(1,2,1)
% imshow(grises)
% subplot(1,2,2)
% bar(rk2,nk1,1)


% nkord=sort(nk,'descend');
% intf1=find(nk==nkord(1))
% intf2=find(nk==nkord(2))
% intf3=find(nk==nkord(3))
% 
% tam1=numel(grises);
% [m,n]=size(grises);
% tam2=m*n;
% rk1=nk./numel(grises);
% suma=cumsum(rk1);
% rk2=suma*256;
% % subplot(2,1,1)
% % bar(rk,nk,0.2);
% % subplot(2,1,2)
% % bar(rk2,nk,20);
% J = histeq(grises);
% subplot(2,2,1)
% imshow(grises);
% subplot(2,2,2)
% imshow(J);
% subplot(2,2,3);
% imhist(grises,64);
% subplot(2,2,4);
% imhist(J,64);
% 