clear
close all

load('dip_hw_2.mat');

rng(1);

% Find the graphs of the images
d2a_graph = Image2Graph(d2a);
d2b_graph = Image2Graph(d2b);

k = 2;

% Find the cluster for every pixel
cluster_d2a = myNCuts(d2a_graph, k);

% Make the cluster back to the image
d2a_new = reshape(cluster_d2a, [50 50]);
d2a_new = d2a_new'./max(cluster_d2a);

figure('Name',['d2a for k=',num2str(k)])
imshow(d2a_new,'InitialMagnification',200);

% Same proccess for the d2b image
cluster_d2b = myNCuts(d2b_graph, k);

d2b_new = reshape(cluster_d2b, [50 50]);
d2b_new = d2b_new'./max(cluster_d2b);

figure('Name',['d2b for k=',num2str(k)])
imshow(d2b_new,'InitialMagnification',200);

d2a_ncutvalue = calculateNcut(d2a_graph, cluster_d2a);
d2b_ncutvalue = calculateNcut(d2b_graph, cluster_d2b);

fprintf('The n-cut value for d2a is: %f and for d2b is: %f\n',d2a_ncutvalue,d2b_ncutvalue);
