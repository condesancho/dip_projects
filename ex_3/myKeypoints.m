function keypoints = myKeypoints(DoGs)

    % Extract no. octaves
    octaves = size(DoGs,2);
    
    index = 1;
    keypoints = [];
    
    for i = 1:octaves
        
        % Extract DoGs from an octave and their dimensions
        dogs = DoGs{1,i};
        [n,m,levels] = size(dogs);
        
        % Check every DoG except the first and the last       
        for j = 2:levels-1
            
            % Check every pixel except the ones in the perimeter of the image
            for k = 2:n-1
                for l = 2:m-1
                    cube = dogs(k-1:k+1, l-1:l+1, j-1:j+1);
                    
                    max_cube = max(max(max(cube)));
                    min_cube = min(min(min(cube)));
                    
                    centre_cube = cube(2,2,2);                    
                    
                    if centre_cube == max_cube || centre_cube == min_cube
                        keypoints(index,:) = [i,j,k,l];
                        index = index + 1;
                    end
                        
                end
            end
            
        end
        
    end

end