clear all
clc

umbral= 10;

imagen =imread('Koala.jpg');
imagenGrises=rgb2gray(imagen);

[m,n]=size(imagenGrises);

for i=1:m
    for j=1:n
        if imagenGrises(i,j) < umbral
            imagenUmbral(i,j)=0;
        else
            imagenUmbral(i,j)=255;
        end
    end   
end

subplot(2,2,1);
imshow(imagenGrises)

subplot(2,2,2);
imshow(imagenUmbral)