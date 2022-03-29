function [spacescales, DoGs] = myDoGs(img, K, sigma, levels, octaves)

    % Initialize variables
    spacescales = cell(1,octaves);
    DoGs = cell(1,octaves);        
    
    % Matrix used for the convolution
    L_previous = img;    
    
    % The sigma used to make the filters
    temp_sigma = sigma;
    
    
    % This variable will temporarily store all the space scales of an
    % octave until it's completed. Same with variable dog for the DoGs
    Ls = zeros([size(img),levels]);
    dog = zeros([size(img),levels-1]);

    for i = 1:octaves
        
        for j = 1:levels
            
            % Calculate filter            
            filter = my2DGaussianFilter(K, temp_sigma);
            
            L = conv2(L_previous, filter, 'same');
            
            % Add the L space scale in the variable to enter the cell spacescales
            Ls(:,:,j) = L;
            
            % After the second spacescale is calculated find the DoGs
            if j > 1                
                dog(:,:,j-1) = Ls(:,:,j) - Ls(:,:,j-1);
            end                       
            
            % Prepare variables for the next iteration
            temp_sigma = sqrt(2)*temp_sigma;
            L_previous = L;                    
            
        end
        
        % Add the variables to the cells
        spacescales(1,i) = {Ls};
        DoGs(1,i) = {dog};
        
        % Downsample the third space scale
        L_previous = imresize(Ls(:,:,3), 0.5);
        
        % Set up variables for next iteration
        Ls = zeros([size(L_previous),levels]);
        dog = zeros([size(L_previous),levels-1]);
                
        temp_sigma = (2^i)*sigma;
        
    end
    
end