% CRV_WS1718_21_QuiverPlot
% name : Piush Aggarwal
% student number: 3063246

% clean up
clear all;
close all;
clc;
% [X,Y] = meshgrid(1:1:10);
% U = 0 * X
% V = 0.5 * ones(size(Y))
% c = quiver(X,Y,U,V)
img = imread('cameraman.tif');
set_to_max = @(blockstruct) ones(size(blockstruct.data),class(blockstruct.data)) * max(blockstruct.data(:));
grainsize = [15, 15];   %if you want the new boxes to be 64 x 64
Maxed_Image = blockproc(img, grainsize, set_to_max);
imshow(Maxed_Image)
[A,B] = meshgrid(8:15:248)
C = 0.5 * ones(size(A))
D = 0.5 * ones(size(B))
quiver(A,B,C,D)

