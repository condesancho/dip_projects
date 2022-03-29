close all
clear

%% Turn image to RGB
load('march.mat');
xrgb = bayer2rgb(x);

%% Resize image
xrgbres = myresize(xrgb, 150, 200, 'linear');

%% Quantize image
bits = 3;

w = 1/2^bits;

qrgb = imagequant(xrgbres, w, w, w);

%% Save image to ppm file
filename = 'dip_is_fun.ppm';
K = 1/w;
saveasppm(qrgb, filename, K);

imshow(filename);