% CRV_WS1718_21_QuiverPlot
% name : Piush Aggarwal
% student number: 3063246

% clean up
clear all;
close all;
clc;
% [X,Y] = meshgrid(1:1:10);
% U = 0 * X
% V = 0.5 * ones(10)
% quiver(X,Y,U,V)
% colormap hsv
% I = imread('cameraman.tif');
% imshow(I)
q = quiver(I,1:15,1:15);
c = q.Color;
q.Color = 'red';

