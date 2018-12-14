clc; clear; close all; warning off all;
 
% membaca citra rgb
Img = imread('e:\cacat.jpg');
figure,imshow(Img);
 
% mengkonversi citra rgb menjadi grayscale
I = double(rgb2gray(Img));
figure, imshow(I,[]);
 
% Konvolusi dengan operator Roberts
robertshor = [0 1; -1 0];
robertsver = [1 0; 0 -1];
Ix = conv2(I,robertshor,'same');
Iy = conv2(I,robertsver,'same');
J = sqrt((Ix.^2)+(Iy.^2));
 
% Menampilkan citra hasil konvolusi
figure,imshow(Ix,[]);
figure,imshow(Iy,[]);
figure,imshow(J,[]);
 
% melakukan thresholding citra
K = uint8(J);
L = im2bw(K,.08);
figure, imshow(L,[]);
 
% melakukan operasi morfologi
M = imfill(L,'holes');
N = bwareaopen(M,10000);
figure, imshow(N,[]);
 
% mengambil bounding box masing2 objek hasil segmentasi
[labeled, numObjects] = bwlabel(N,8);
stats = regionprops(labeled,'BoundingBox');
bbox = cat(1, stats.BoundingBox);
 
% menampilkan citra rgb hasil segmentasi
figure, imshow(Img);
hold on;
for idx = 1 : numObjects
    h = rectangle('Position',bbox(idx,:),'LineWidth',2);
    set(h,'EdgeColor',[.75 0 0]);
    hold on;
end
 
% menampilkan jumlah objek hasil segmentasi
title(['There are ', num2str(numObjects),...
    ' objects in the image!']);
hold off;