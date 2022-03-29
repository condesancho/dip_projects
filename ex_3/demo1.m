clear
clc
close all

%% Load images
load('dip_hw_3.mat')

%% Set variables 
sigma = sqrt(2);
K = 7;

%% Execute for two values of levels and octaves
for i = 1:2
    if i == 1
        levels = 5;
        octaves = 3;
    elseif i == 2
        levels = 3;
        octaves = 7;
    end
    
    %% Execute function for both images
    [spaceMoun, dogsMoun] = myDoGs(mountains, K, sigma, levels, octaves);
    [spaceRoof, dogsRoof] = myDoGs(roofs, K, sigma, levels, octaves);

    %% Plot the mountains
    figure
    title('The space scales');
    % Spacescales
    for i = 1:octaves
    
        spacescales = spaceMoun{1,i};
        
        for j = 1:levels
        
            subplot(octaves, levels, (i-1)*levels+j)
            imshow(spacescales(:,:,j));
            title(['Octave ',num2str(i),', level ',num2str(j)]);
        
        end
    end

    figure
    % DoGs
    for i = 1:octaves
    
        dogs = dogsMoun{1,i};
        
        for j = 1:levels-1
        
            subplot(octaves, levels-1, (i-1)*(levels-1)+j)
            im = rescale(dogs(:,:,j));
            imshow(im);
            title(['Octave ',num2str(i),', DoG ',num2str(j)]);
        
        end
    end

    %% Plot the roofs
    figure
    title('The space scales for the roofs');
    % Spacescales
    for i = 1:octaves
    
        spacescales = spaceRoof{1,i};
        
        for j = 1:levels
        
            subplot(octaves, levels, (i-1)*levels+j)
            imshow(spacescales(:,:,j));
            title(['Octave ',num2str(i),', level ',num2str(j)]);
        
        end
    end

    figure
    % DoGs
    for i = 1:octaves
    
        dogs = dogsRoof{1,i};
        
        for j = 1:levels-1
        
            subplot(octaves, levels-1, (i-1)*(levels-1)+j)
            im = rescale(dogs(:,:,j));
            imshow(im);
            title(['Octave ',num2str(i),', DoG ',num2str(j)]);
        
        end
    end

end