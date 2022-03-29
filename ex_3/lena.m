clear
clc
close all

%% Load images
len = imread('lena.png');
mountains = rescale(len(:,:,1));

%% Set variables for 1st execution
sigma = sqrt(2);
K = 9;
levels = 5;
octaves = 3;

%% Execute function for both images
[spaceMoun, dogsMoun] = myDoGs(mountains, K, sigma, levels, octaves);

%% Find keypoints
keyMoun = myKeypoints(dogsMoun);

%% Make plots for mountains
key_row = 1;
idx = 1;
figure('Name','DoGs with their corresponding keypoints')
for i = 1:octaves
    dogs = dogsMoun{1,i};
    
    for j = 1:levels-1
        
        subplot(octaves,levels-1,idx)
        im = rescale(dogs(:,:,j));
        imshow(im);        
        
        idx = idx + 1;
        
        while key_row <= size(keyMoun,1)            
            if keyMoun(key_row,1) == i && keyMoun(key_row,2) == j
                hold on
                plot(keyMoun(key_row,4),keyMoun(key_row,3),'x','Color','r')
                hold off
                key_row = key_row + 1;
            else
                break
            end
        end
        
    end
end

figure('Name','Image with salient points')
imshow(mountains);
hold on
for i = 1:size(keyMoun,1)
    if keyMoun(i,1) == 1
        plot(keyMoun(i,4),keyMoun(i,3),'x','Color','r')
    else
        % The multiplier for reverting the pixel position from a
        % downsampled image
        mult = 2^(keyMoun(i,1)-1);
        
        plot(mult*keyMoun(i,4),mult*keyMoun(i,3),'x','Color','r')
    end
end
hold off

%% Set up variables
nspo = levels - 2;
p = 0.4;
t = (2^(1/nspo)-1)/(2^(1/3)-1)*0.015;

%% Discard keypoints
keyHCMoun = discardLowContrasted(dogsMoun, keyMoun, t, p);

%% High contrasted keypoints in the original images
figure('Name','Image with high contrasted salient points')
imshow(mountains);
hold on
for i = 1:size(keyHCMoun,1)
    if keyHCMoun(i,1) == 1
        plot(keyHCMoun(i,4),keyHCMoun(i,3),'x','Color','r')
    else
        % The multiplier for reverting the pixel position from a
        % downsampled image
        mult = 2^(keyHCMoun(i,1)-1);
        
        plot(mult*keyHCMoun(i,4),mult*keyHCMoun(i,3),'x','Color','r')
    end
end
