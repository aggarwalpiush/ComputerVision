% CRV_WS1718_21_QuiverPlot
% name : Piush Aggarwal
% student number: 3063246

% clean up
clear all;
close all;
clc;
subplot(1,2,1)
hold on
[X,Y] = meshgrid(1:1:10);
U = 0 * X
V = 0.5 * ones(size(Y))
c = quiver(X,Y,U,V)
subplot(1,2,2)
img = imread('cameraman.tif');
max_window = @(blockstruct) ones(size(blockstruct.data),class(blockstruct.data)) * max(blockstruct.data(:));
blocks = [15, 15]; 
Divide_Image = blockproc(img, blocks, max_window);
imshow(Divide_Image)
hold on
[A,B] = meshgrid(8:15:248)
C = 0.5 * ones(size(A))
D = 0.5 * ones(size(B))
quiver(A,B,C,D)


