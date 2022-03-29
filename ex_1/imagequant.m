function q = imagequant(x, w1, w2, w3)

    % Red
    q(:,:,1) = myquant(x(:,:,1), w1);
    % Green
    q(:,:,2) = myquant(x(:,:,2), w2);
    % Blue
    q(:,:,3) = myquant(x(:,:,3), w3);


end