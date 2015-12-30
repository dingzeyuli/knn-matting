clear
close all

disp('starting the KNN Matting demo');
run ('../vlfeat-0.9.20/toolbox/vl_setup');

input  = im2double(imread('../data/inputs/GT20.png'));
trimap = im2double(imread('../data/trimaps/Trimap1/GT20.png'));
trimap = reshape(trimap(:,:,1), [], 1);

lambda = 100;
level  = 1;

tic
output = knn_matting(input, trimap, lambda, level);
toc

figure; imshow(output);

