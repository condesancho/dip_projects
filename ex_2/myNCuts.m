function clusterIdx = myNCuts(anAffinityMat, k)

    D = sum(anAffinityMat,2).*eye(size(anAffinityMat,1));
    
    L = D - anAffinityMat;
    
    [U,~] = eigs(L,D,k,'smallestreal');
    
    clusterIdx = kmeans(U, k);

end