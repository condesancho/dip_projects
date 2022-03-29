clear
clc
close all

%% Load images
load('dip_hw_3.mat')

mountains = imresize(mountains, [512,512]);
roofs = imresize(roofs, [512,512]);

%% Set variables for 1st execution
sigma = sqrt(2);
K = 11;
levels = 5;
octaves = 3;

%% Execute function for both images
[spaceMoun, dogsMoun] = myDoGs(mountains, K, sigma, levels, octaves);
[spaceRoof, dogsRoof] = myDoGs(roofs, K, sigma, levels, octaves);

%% Find keypoints
keyMoun = myKeypoints(dogsMoun);
keyRoof = myKeypoints(dogsRoof);

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

%% Make plots for roofs
key_row = 1;
idx = 1;

figure('Name','DoGs with their corresponding keypoints')
for i = 1:octaves
    dogs = dogsRoof{1,i};
    
    for j = 1:levels-1
        
        subplot(octaves,levels-1,idx)
        im = rescale(dogs(:,:,j));
        imshow(im);
        
        idx = idx + 1;
        
        while key_row <= size(keyRoof,1)            
            if keyRoof(key_row,1) == i && keyRoof(key_row,2) == j
                hold on
                plot(keyRoof(key_row,4),keyRoof(key_row,3),'x','Color','r')
                hold off
                key_row = key_row + 1;
            else
                break
            end
        end
        
    end
end


figure('Name','Image with salient points')
imshow(roofs);
hold on
for i = 1:size(keyRoof,1)
    if keyRoof(i,1) == 1
        plot(keyRoof(i,4),keyRoof(i,3),'x','Color','r')
    else
        % The multiplier for reverting the pixel position from a
        % downsampled image
        mult = 2^(keyRoof(i,1)-1);
        
        plot(mult*keyRoof(i,4),mult*keyRoof(i,3),'x','Color','r')
    end
end
hold off


%% Set up variables
nspo = levels - 2;
p = 0.4;
t = (2^(1/nspo)-1)/(2^(1/3)-1)*0.015;

%% Discard keypoints
keyHCMoun = discardLowContrasted(dogsMoun, keyMoun, t, p);
keyHCRoof = discardLowContrasted(dogsRoof, keyRoof, t, p);

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
hold off

figure('Name','Image with high contrasted salient points')
imshow(roofs);
hold on
for i = 1:size(keyHCRoof,1)
    if keyHCRoof(i,1) == 1
        plot(keyHCRoof(i,4),keyHCRoof(i,3),'x','Color','r')
    else
        % The multiplier for reverting the pixel position from a
        % downsampled image
        mult = 2^(keyHCRoof(i,1)-1);
        
        plot(mult*keyHCRoof(i,4),mult*keyHCRoof(i,3),'x','Color','r')
    end
end
