clear
clc

load('dip_hw_2.mat');

% Select seed
rng(1);

% Make clusters for k = 2,3,4
cluster2 = mySpectralClustering(d1a, 2);
cluster3 = mySpectralClustering(d1a, 3);
cluster4 = mySpectralClustering(d1a, 4);

% Print the clusters
fprintf('For k = 2 the cluster is: ')
fprintf('%d ',cluster2)
fprintf('\nFor k = 3 the cluster is: ')
fprintf('%d ',cluster3)
fprintf('\nFor k = 4 the cluster is: ')
fprintf('%d ',cluster4)
fprintf('\n')