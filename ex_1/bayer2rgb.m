function xrgb = bayer2rgb(xb)

    % Initialize the image
    xrgb = zeros(size(xb,1), size(xb,2), 3);

    % Arrays that hold only one colour
    % Positions of different colours are zero
    only_R = zeros(size(xb));
    only_G = zeros(size(xb));
    only_B = zeros(size(xb));
    
    % Fill the previous arrays
    % It is known that the pattern is gbrg
    for i = 1:size(xb,1)
        for j = 1:size(xb,2)
            if (mod(i,2) == 1) && (mod(j,2) == 1)
               only_G(i,j) = xb(i,j);
            elseif (mod(i,2) == 0) && (mod(j,2) == 1)
               only_R(i,j) = xb(i,j);
            elseif (mod(i,2) == 1) && (mod(j,2) == 0)
               only_B(i,j) = xb(i,j);
            else
               only_G(i,j) = xb(i,j);
            end     
        end
    end
    
    % Extend arrays by 1 in each side with the mirroring method
    only_R = wextend('2D','symw',only_R,1);
    only_G = wextend('2D','symw',only_G,1);
    only_B = wextend('2D','symw',only_B,1);
    
    % Mask for red and blue
    rbmask = (1/4)*[1 2 1; 2 4 2; 1 2 1];
    % Mask for green
    gmask = (1/4)*[0 1 0; 1 4 1; 0 1 0];
    
    % The extended image
    xrgb_ext(:,:,1) = conv2(only_R, rbmask, 'same');
    xrgb_ext(:,:,2) = conv2(only_G, gmask, 'same');
    xrgb_ext(:,:,3) = conv2(only_B, rbmask, 'same');
    
    % Crop the extended image
    xrgb(:,:,1) = xrgb_ext(2:size(xrgb_ext,1)-1,2:size(xrgb_ext,2)-1,1);
    xrgb(:,:,2) = xrgb_ext(2:size(xrgb_ext,1)-1,2:size(xrgb_ext,2)-1,2);
    xrgb(:,:,3) = xrgb_ext(2:size(xrgb_ext,1)-1,2:size(xrgb_ext,2)-1,3);

end