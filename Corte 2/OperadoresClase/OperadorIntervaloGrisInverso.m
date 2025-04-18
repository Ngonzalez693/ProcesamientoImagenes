clear all
clc

umbral1=50;
umbral2=100;

imagen =imread('Koala.jpg');
imagenGrises=rgb2gray(imagen);

[m,n]=size(imagenGrises);

for i=1:m
    for j=1:n
        if (imagenGrises(i,j) > umbral1) && (imagenGrises(i,j) < umbral2)
            
%           imagenUmbralInversp(i,j)=255;
            imagenUmbralInversp(i,j)= 255 - imagenGrises(i,j);
           
        else
%           imagenUmbralInversp(i,j)=0;
            imagenUmbralInversp(i,j)=255;
        end
    end   
end

subplot(1,2,1);
imagenGrises = uint8(imagenGrises);
imshow(imagenGrises)

subplot(1,2,2);
imagenUmbralInversp = uint8(imagenUmbralInversp);
imshow(imagenUmbralInversp)