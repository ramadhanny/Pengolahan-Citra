im=imread('e:\14.jpg');
size(im);
gray=rgb2gray(im);
he=imadjust(gray);
se1=[0 1 0; 1 1 1; 0 1 0];
se=strel('square',3);
dil=imdilate(he,se);
erosi=imerode(dil,se);
op=imopen(dil,se1);
tepi=edge(op,'log');
subplot(2,2,1), imshow(gray); subplot(2,2,2), imshow(tepi);