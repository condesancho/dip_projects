function clusterIdx = mySpectralClustering(anAffinityMat, k)

    D = sum(anAffinityMat,2).*eye(size(anAffinityMat,1));
    
    L = D - anAffinityMat;
    
    [U,~] = eigs(L,k,'smallestreal');
    
    clusterIdx = kmeans(U, k);

end