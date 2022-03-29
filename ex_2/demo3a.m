clear
close all
clc

load('dip_hw_2.mat');

rng(1);

% Find the graphs of the images
d2a_graph = Image2Graph(d2a);
d2b_graph = Image2Graph(d2b);

for k = 2:4
    % Find the cluster for every pixel
    cluster_d2a = myNCuts(d2a_graph, k);

    % Make the cluster back to the image
    d2a_new = reshape(cluster_d2a, [50 50]);
    d2a_new = d2a_new'./max(cluster_d2a);
    figure('Name',['d2a for k=',num2str(k)])
    imshow(d2a_new,'InitialMagnification',200);
    % imwrite(d2a_new, ['3_a_',num2str(k),'.png']);

    % Same proccess for the d2b image
    cluster_d2b = myNCuts(d2b_graph, k);

    d2b_new = reshape(cluster_d2b, [50 50]);
    d2b_new = d2b_new'./max(cluster_d2b);
    figure('Name',['d2b for k=',num2str(k)])
    imshow(d2b_new,'InitialMagnification',200);
    % imwrite(d2b_new, ['3_b_',num2str(k),'.png']);
end