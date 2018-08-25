%% CRV_WS1718_25_ImageSequenceAnalysisActiveContours
% name : Piush Aggarwal
% student number : 3063246

%% clean up
clear all;
close all;
clc ;
figure(1);
Img = imread('1\image_1.png');
mask = roipoly(Img);
cont_img = activecontour(Img,mask,500);
imshow(Img);
hold on;
visboundaries(Img,'color','r');
visboundaries(cont_img,'color','b');
print('-f1','ouput','-dpng');
hold off;
figure(2);
imshow(Img);
visboundaries(Img,'color','r');
hold on;
visboundaries(cont_img,'color','b');
hold on;
srcFiles = dir('1\*.png');  
for i = 1 : length(srcFiles)
    filename = strcat('1\',srcFiles(i).name);
    I = imread(filename);
    new_I = activecontour(I,cont_img,50);
    imshow(I);
    hold on;
    visboundaries(new_I,'color','r');
    cont_img = new_I;
    hold on;
end
print('-f2','ouput_final','-dpng')


