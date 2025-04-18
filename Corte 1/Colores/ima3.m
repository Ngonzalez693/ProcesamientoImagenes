close all;
clear all;
clc;
ht=50;
w=50;
wt=3*w;

I1=zeros(ht,wt,3);
I1(1:ht, 1:w , 2)=255;

I2=zeros(ht,wt,3);
I2(1:ht, 1:w , 2)=255;

I3=zeros(ht,wt,3);


%%%%%%%
I3(1:ht, 1:w , 2)=255;
I1(1:ht, w+1:2*w,1)=255;
I1(1:ht, w+1:2*w,2)=128;
I1(1:ht, w+1:2*w,3)=0;

I1(1:ht, 2*w+1:3*w, 1)=255;
%%%%%%%%
I3(1:ht, 1:w , 2)=255;
I2(1:ht, w+1:2*w,1)=140;
I2(1:ht, w+1:2*w,2)=80;
I2(1:ht, w+1:2*w,3)=0;

I2(1:ht, 2*w+1:3*w, 1)=255;

%%%%%%%%
I3(1:ht, 1:w , 2)=255;
I3(1:ht, w+1:2*w,1)=255;
I3(1:ht, w+1:2*w,2)=128;
I3(1:ht, w+1:2*w,3)=0;

I3(1:ht, 2*w+1:3*w, 1)=255;
%%%%%%%%


h1=figure;
I1=uint8(I1);
I2=uint8(I2);
I3=uint8(I3);


subplot(3,1,1);
imshow(I1);
subplot(3,1,2);
imshow(I2);
subplot(3,1,3);
imshow(I3);

