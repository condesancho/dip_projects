close all
clear

%% Load and colour image
load('march.mat');
xrgb = bayer2rgb(x);

%% Resize image
xrgbres = myresize(xrgb, 240, 320, 'nearest');
imshow(xrgbres,'InitialMagnification',300);

figure
xrgbreslin = myresize(xrgb, 200, 300, 'linear');
imshow(xrgbreslin,'InitialMagnification',300);
