function q = myquant(x, w)

    q = zeros(size(x));

    quantization_levels = ceil(1/w);
    
    for i = 1:quantization_levels
        % Quantize the positive values first
        logical = x<=i*w & x>(i-1)*w;
        q = q + (i-1)*ones(size(x)).*logical;
        
        % Quantize the negative values
        logical = x>=(-i)*w & x<(1-i)*w;
        q = q + (-i)*ones(size(x)).*logical;  
        
    end

end