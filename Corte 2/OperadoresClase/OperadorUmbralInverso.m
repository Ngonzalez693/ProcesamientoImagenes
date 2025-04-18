clear all
clc

umbral= 100;

imagen =imread('Koala.jpg');
imagenGrises=rgb2gray(imagen);

[m,n]=size(imagenGrises);

for i=1:m
    for j=1:n
        if imagenGrises(i,j) > umbral
            imagenUmbralInversp(i,j)=0;
        else
            imagenUmbralInversp(i,j)=255;
        end
    end   
end

subplot(2,2,1);
imshow(imagenGrises)

subplot(2,2,2);
imshow(imagenUmbralInversp)