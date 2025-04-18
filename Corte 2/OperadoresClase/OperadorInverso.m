imagen =imread('Koala.jpg');
imagenGrises=rgb2gray(imagen);

[m,n]=size(imagenGrises);

for i=1:m
    for j=1:n
        imgGrisInverso(i,j) = 255 - imagenGrises(i,j);

    end   
end

subplot(2,2,1);
imshow(imagenGrises)

subplot(2,2,2);
imshow(imgGrisInverso)