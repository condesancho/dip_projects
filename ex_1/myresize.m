function xrgbres = myresize(xrgb, N, M, method)
    
    % Initialize new resized image
    xrgbres = zeros(N, M, 3);
    
    % The step for every dimension
    rows_scale = size(xrgb,1)/N;
    cols_scale = size(xrgb,2)/M;
    
    % Every row of the new image
    for i = 1:N
        % The row of the old image
        xrgb_row = rows_scale*i;
        
        % Every column of the new image
        for j = 1:M
            % The col of the old image
            xrgb_col = cols_scale*j;
            
            switch method
                case 'nearest'
                    % Round to the nearest integer
                    pixel_row = round(xrgb_row);
                    pixel_col = round(xrgb_col);
                    xrgbres(i,j,:) = xrgb(pixel_row, pixel_col,:);
                case 'linear'                    
                    pix_coor = [xrgb_row xrgb_col];                 
                    xrgbres(i,j,:) = interpolation(xrgb, pix_coor);
            end
        end
    end

end


%% Function for interpolation
function new_pix = interpolation(xrgb, pix_coor)

    % Initialize the new value of the pixel
    new_pix = zeros(3,1);

    % Coors of the 4 neighbour pixels of the point
    y(1) = floor(pix_coor(1));
    y(2) = ceil(pix_coor(1));
    x(1) = floor(pix_coor(2));
    x(2) = ceil(pix_coor(2));

    % 3 conditions where interpolation is linear
    if y(1) == y(2) && x(1) == x(2)
        % The coors coincide with a pixel
        new_pix = xrgb(y(1),x(1),:);
        return;
    elseif x(1) == x(2)
        % Interpolate on the y-axis
        dif = pix_coor(1)-y(1);
        m1 = xrgb(y(1),x(1),:).*(1-dif);
        m2 = xrgb(y(2),x(1),:).*dif;
        new_pix = m1 + m2;
        return;
    elseif y(1) == y(2)
        % Interpolate on the x-axis
        dif = pix_coor(2)-x(1);
        m1 = xrgb(y(1),x(1),:).*(1-dif);
        m2 = xrgb(y(1),x(2),:).*dif;
        new_pix = m1 + m2;
        return;
    end
    
    % The interpolation is bilinear
    m1 = [x(2)-pix_coor(2) pix_coor(2)-x(1)];  
    m3 = [y(2)-pix_coor(1); pix_coor(1)-y(1)];
    
    for i = 1:3     
        m2 = [xrgb(y(1),x(1),i) xrgb(y(2),x(1),i);
              xrgb(y(1),x(2),i) xrgb(y(2),x(2),i)];
        new_pix(i) = m1*m2*m3;
    end

end
