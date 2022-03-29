function x = mydequant(q, w)

    x = zeros(size(q));

    quantization_levels = ceil(1/w);

    for i = 1:quantization_levels
        % For positive values
        logical = q==(i-1);
        % They take the mean of the interval of quantization
        x = x + (2*i-1)*(w/2)*ones(size(q)).*logical;
        
        % For negative values
        logical = q==(-i);
        x = x + (2*i-1)*(-w/2)*ones(size(q)).*logical;
        
    end
    

end