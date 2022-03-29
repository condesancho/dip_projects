close all
clear

load('march.mat');

xrgb = bayer2rgb(x);

fprintf('Mask used for red and blue:');
rbmask = (1/4)*[1 2 1; 2 4 2; 1 2 1]
fprintf('Mask used for green:');
gmask = (1/4)*[0 1 0; 1 4 1; 0 1 0]

imshow(xrgb);