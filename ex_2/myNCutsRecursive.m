function clusterIdx = myNCutsRecursive(anAffinityMat, first, T1, T2)

    % Initialize the value to be returned
    clusterIdx = zeros(size(anAffinityMat,1),1);
    
    cluster = myNCuts(anAffinityMat,2);

    % Find how many elements belong in each cluster
    noOnes = sum(cluster==1);
    noTwos = sum(cluster==2);
    
    % Condition for T1
    if noOnes < T1 || noTwos < T1
        % Executes in the first call of the function
        if first == 1
            clusterIdx = cluster;
        else
            clusterIdx = ones(size(cluster));
        end
        return
    end
    
    nCut = calculateNcut(anAffinityMat, cluster);
    
    % Condition for T2
    if nCut > T2
        % Executes in the first call of the function
        if first == 1
            clusterIdx = cluster;
        else
            clusterIdx = ones(size(cluster));
        end
        return
    end
    
    % Divide clusters in 2 groups
    pointIdx1 = find(cluster==1);
    pointIdx2 = find(cluster==2);
    
    % Make the new affinity matrices for the 2 groups
    affinity1 = anAffinityMat(pointIdx1,pointIdx1);
    affinity2 = anAffinityMat(pointIdx2,pointIdx2);
    
    % Find the new clusters
    cluster1 = myNCutsRecursive(affinity1, 0, T1, T2);
    cluster2 = myNCutsRecursive(affinity2, 0, T1, T2);
    
    % Add the max id of cluster1 to cluster2
    cluster2 = cluster2 + max(cluster1);
    
    % Join the 2 clusters and their indices
    clusterIdx = [cluster1; cluster2];
    pointIndices = [pointIdx1; pointIdx2];
    
    [~,indices] = sort(pointIndices);
    
    % Rearrange points in the right order according to their original index
    clusterIdx = clusterIdx(indices);

end