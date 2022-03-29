function myAffinityMat = Image2Graph(imIn)

    % No. rows
    M = size(imIn,1);

    % No. cols
    N = size(imIn,2);
    
    affinityDimension = M*N;

    myAffinityMat = zeros(affinityDimension);

    % Pixels follow row major format %
    
    % Iterate every row
    for i = 1:affinityDimension
        % Iterate every column up to the diagonal
        for j = 1:i
            
            % First point
            rowA = floor((i-1)/N)+1;
            colA = mod(i,N);
            if colA == 0
                colA = N;
            end
            % A is a 1 by 1 by 3 matrix
            A = imIn(rowA, colA, :);
            % Make column vector
            A = reshape(A, [size(A,3),1]);
            
            % Second point
            rowB = floor((j-1)/N)+1;
            colB = mod(j,N);
            if colB == 0
                colB = N;
            end
            
            % B is a 1 by 1 by 3 matrix
            B = imIn(rowB, colB, :);
            % Make it a column vector
            B = reshape(B, [size(B,3),1]);
            
            dist = norm(A-B);
            
            myAffinityMat(i,j) = 1/exp(dist);
            
        end
    end

    myAffinityMat = myAffinityMat + myAffinityMat' - myAffinityMat.*eye(affinityDimension);

end