clear
clc

load('dip_hw_2.mat');

rng(1);

% Variables
T1 = 5;
T2 = .2;
% Find the graphs of the images
d2a_graph = Image2Graph(d2a);
d2b_graph = Image2Graph(d2b);

% Find the cluster for every pixel
cluster_d2a = myNCutsRecursive(d2a_graph, 1, T1, T2);

% Make the cluster back to the image
d2a_new = reshape(cluster_d2a, [50 50]);
k = max(cluster_d2a);
d2a_new = d2a_new'./k;
figure('Name',['d2a for T1 = ',num2str(T1),', T2 = ',num2str(T2),' and k = ',num2str(k)])
imshow(d2a_new,'InitialMagnification',200);
% imwrite(d2a_new, ['4_a_',num2str(k),'_',num2str(T2),'.png']);


% Same proccess for the d2b image
cluster_d2b = myNCutsRecursive(d2b_graph, 1, T1, T2);

d2b_new = reshape(cluster_d2b, [50 50]);
k = max(cluster_d2b);
d2b_new = d2b_new'./k;
figure('Name',['d2b for T1 = ',num2str(T1),', T2 = ',num2str(T2),' and k = ',num2str(k)])
imshow(d2b_new,'InitialMagnification',200);
% imwrite(d2b_new, ['4_b_',num2str(k),'_',num2str(T2),'.png']);