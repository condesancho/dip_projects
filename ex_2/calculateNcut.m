function nCutValue = calculateNcut(anAffinityMatrix, clusterIdx)

    assocAA = 0;
    assocAV = 0;
    assocBB = 0;
    assocBV = 0;

    % Iterate every element of the affinity matrix
    % and add its weight to the appropriate assocs
    for i = 1:size(anAffinityMatrix,1)
        for j = 1:size(anAffinityMatrix,2)
            % The pixels belong to A
            if clusterIdx(i) == 1 && clusterIdx(j) == 1
                assocAA = assocAA + anAffinityMatrix(i,j);
                assocAV = assocAV + anAffinityMatrix(i,j);
            % One pixel belongs to A and the other to V
            elseif clusterIdx(i) ~= clusterIdx(j) && clusterIdx(i) == 1
                assocAV = assocAV + anAffinityMatrix(i,j);
            % One pixel belongs to B and the other to V
            elseif clusterIdx(i) ~= clusterIdx(j) && clusterIdx(i) == 2
                assocBV = assocBV + anAffinityMatrix(i,j);
            % The pixels belong to B    
            elseif clusterIdx(i) == 2 && clusterIdx(j) == 2
                assocBB = assocBB + anAffinityMatrix(i,j);
                assocBV = assocBV + anAffinityMatrix(i,j);
            end
                
        end
    end
    
    nAssoc = assocAA/assocAV + assocBB/assocBV;
    
    nCutValue = 2 - nAssoc;

end