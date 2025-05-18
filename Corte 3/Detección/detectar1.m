clc;
close all;
clear all;
RGB = imread('pillsetc.png'); 
% imshow(RGB);

I = rgb2gray(RGB);
bw = imbinarize(I); 
% subplot(4,1,1);
% imshow(RGB);
% subplot(4,1,2);
% % imshow(I);
% subplot(1,4,1);
% imshow(bw);
bw2 = bwareaopen(bw,800); 
% % imshow(bw);
% % subplot(1,4,2);
% imshow(bw2);
se = strel('disk',2); 
bw3 = imclose(bw2,se); 
% subplot(1,4,3);
% imshow(bw3);
bw4 = imfill(bw3,'holes'); 
% subplot(1,4,4);
% imshow(bw4);
[B,L] = bwboundaries(bw4,'noholes');
imshow(label2rgb(L,@jet,[.5 .5 .5])) 
hold on 
for k = 1:length(B)  
    boundary = B{k};   
    plot(boundary(:,2),boundary(:,1),'w','LineWidth',2) 
end
