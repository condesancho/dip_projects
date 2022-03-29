function saveasppm(x, filename, K)

    % Create PPM file
    ppmfile = fopen(filename, 'w');
    
    % Conditions for K
    if K < 257
        bytes_used = 'uint8';
    elseif K < 65537
        bytes_used = 'uint16';
    else
        fprintf('Unable to write ppm file.\n');
        return
    end

    % Write header of file
    fprintf(ppmfile, 'P6 %d %d %d\n', size(x,2), size(x,1), K-1);
    
    % Write binary value of red, green and blue for every pixel
    for i = 1:size(x,1)
        for j = 1:size(x,2)           
            fwrite(ppmfile, x(i,j,1), bytes_used,'b');
            fwrite(ppmfile, x(i,j,2), bytes_used,'b');
            fwrite(ppmfile, x(i,j,3), bytes_used,'b');            
        end
    end
    
    fclose(ppmfile);

end