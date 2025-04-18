clear all
clc

umbral1=200;
umbral2=250;

imagen =imread('Koala.jpg');
imagenGrises=rgb2gray(imagen);

[m,n]=size(imagenGrises);

for i=1:m
    for j=1:n
        if imagenGrises(i,j) > umbral1 && imagenGrises(i,j) < umbral2
            
%           imagenUmbralInversp(i,j)=255;
            imagenUmbralInversp(i,j)=0;
           
        else
%           imagenUmbralInversp(i,j)=0;
            imagenUmbralInversp(i,j)=255;
        end
    end   
end

subplot(1,2,1);
imshow(imagenGrises)

subplot(1,2,2);
imshow(imagenUmbralInversp)