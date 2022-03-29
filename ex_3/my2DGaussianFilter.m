function myGFilter = my2DGaussianFilter(K, sigma)

    first_term = 1/(2*pi*sigma^2);

    % We assume that K is an odd value and the centre is at N+1
    % meaning (N+1, N+1) corresponds to (0,0) of the filter
    N = floor(K/2);
    
    myGFilter = zeros(K,K);
    
    for y = -N:N
        for x = -N:N            
            
            power = (x^2+y^2)/(2*sigma^2);            
            myGFilter(x+N+1,y+N+1) = first_term*exp(-power);
                        
        end
    end
    
    total_sum = sum(sum(myGFilter));
    
    % Normalize the filter
    myGFilter = myGFilter./total_sum;

end