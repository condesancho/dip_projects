close all
clear

%% Load and colour image
load('march.mat');
xrgb = bayer2rgb(x);

%% Quantize image
bits = 3;
w = 1/2^bits;

qrgb = imagequant(xrgb, w, w, w);

xrgb_quan = imagedequant(qrgb, w, w, w);

imshow(xrgb_quan);