umbral = 50;
umbral2 = 100;
imagen  = imread('Koala.jpg');
imGris  = rgb2gray(imagen);
[m,n] = size(imGris);

 for i=1:m
    for j=1:n 
        if (imGris(i,j) >= umbral) && (imGris(i,j) <= umbral2)
            imGris2(i,j) = round(-20*(double(imGris(i,j))-umbral)/((umbral2-umbral))+20);
            
        else
            imGris2(i,j) = 255;
        end
     
    end
 end
 
subplot(2,2,1);
imGris = uint8(imGris);
imshow(imGris);

subplot(2,2,2);
imGris2 = uint8(imGris2);
imshow(imGris2);