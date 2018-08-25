%% CRV_WS1718_29_ExistenceOfObstacles
% name: Piush Aggarwal
% student number: 3063246

%% clean up
clear all;
close all;
clc;

%% Select sequence
imgSeqDir = ['sequences', filesep, '1', filesep];
imgSeqN = length(dir(imgSeqDir))-2;

%% ComputerVisionToolbox
% Check if computer vision toolbox (CVTB) is available
has_CVTB = license('test','video_and_image_blockset');

% If CVTB is not available load workspace file containing correspondences
if ~has_CVTB
    load('corresPoints.mat');
end

%% Image sequence analysis

f = figure();

for k=1:imgSeqN
    % Load image
    I = rgb2gray(imread([imgSeqDir,'image_',int2str(k),'.png']));
    
    % Show image
    figure(f)
    imshow(I);
    hold on;
    
    % Iteration of eight tiles
    for t=1:8
        
        % Define the ROI/tile coordinates and draw it
        roiP = [128*(t-1)+1,128*5,128,128*2];
        imrect(gca, roiP);
        
        if has_CVTB
            % Detect salient points in ROI and extract features
            ptsCurr = detectSURFFeatures(I,'ROI',roiP, 'MetricThreshold',1 );
            [tiles(t).featuresCurr,tiles(t).validPtsCurr] = ...
                extractFeatures(I,ptsCurr);
        end
        
        
        if k>1
            if has_CVTB
                % Match features of previous and current image
                [indexPairs,matchmetric] = matchFeatures(tiles(t).featuresPrev,tiles(t).featuresCurr,'Unique',true);
                
                % Extract coordinates of corresponding points
                matchedPrev = tiles(t).validPtsPrev(indexPairs(:,1));
                matchedCurr = tiles(t).validPtsCurr(indexPairs(:,2));
                
                % Save coordinates in lecture notation
                X = matchedPrev.Location(:,1);
                Y = matchedPrev.Location(:,2);
                XPrime = matchedCurr.Location(:,1);
                YPrime = matchedCurr.Location(:,2);
                
            else
                % Save coordinates in lecture notation
                X = correspondences(k-1,t).X;
                Y = correspondences(k-1,t).Y;
                XPrime = correspondences(k-1,t).XPrime;
                YPrime = correspondences(k-1,t).YPrime;
            end
            
            % Plot points in current image, which have a match withb
            % salient point from previous image
            plot(XPrime,YPrime,'y.','MarkerSize',10);
            
            %%%
            if has_CVTB
                                % Match features of previous and current image
                [indexPairs,matchmetric] = matchFeatures(tiles(t).featuresPrev,tiles(t).featuresCurr,'Unique',true);
                
                % Extract coordinates of corresponding points
                matchedPrev = tiles(t).validPtsPrev(indexPairs(:,1));
                matchedCurr = tiles(t).validPtsCurr(indexPairs(:,2));
                
                mul1 = matchedPrev.Location(:,1) * matchedCurr.Location(:,1);
                mul2 = matchedPrev.Location(:,2) * matchedCurr.Location(:,1);
                mul3 = matchedPrev.Location(:,1) * matchedCurr.Location(:,2);
                mul4 = matchedPrev.Location(:,2) * matchedCurr.Location(:,2);                
                M_cor = [matchedPrev.Location(:,1) matchedPrev.Location(:,2) 1 0 0 0 mul1 mul2;
                    0 0 0 matchedPrev.Location(:,1) matchedPrev.Location(:,2) 1 mul3 mul4]'
                M_nex = [matchedCurr.Location(:,1) matchedCurr.Location(:,2)]'
                Mcn = [M_cor;Mnex]
                S_M_nex = svd(M_nex)
                S_Mcn = svd(Mcn)
            else
                M_cor = [];
                M_nex = [];
                for c = 1:length(correspondences(k-1,t).X)
                    mul1 = correspondences(k-1,t).X(c) * correspondences(k-1,t).XPrime(c);
                    mul2 = correspondences(k-1,t).Y(c) * correspondences(k-1,t).XPrime(c);
                    mul3 = correspondences(k-1,t).X(c) * correspondences(k-1,t).YPrime(c);
                    mul4 = correspondences(k-1,t).Y(c) * correspondences(k-1,t).YPrime(c);                
                    M_cor_new = [correspondences(k-1,t).X(c) correspondences(k-1,t).Y(c) 1 0 0 0 -1*mul1 -1*mul2;
                        0 0 0 correspondences(k-1,t).X(c) correspondences(k-1,t).Y(c) 1 -1*mul3 -1*mul4];
                    M_cor = [M_cor;M_cor_new];
                    M_nex_new = [correspondences(k-1,t).XPrime(c) correspondences(k-1,t).YPrime(c)]' ;
                    M_nex = [M_nex;M_nex_new];
                end
                Mcn = [M_cor';M_nex']
                S_M_nex = svd(M_cor')
                S_Mcn = svd(Mcn) 
            end
            %%%
            
        end
        
        if has_CVTB
            % Prepare next iteration
            tiles(t).featuresPrev = tiles(t).featuresCurr;
            tiles(t).validPtsPrev = tiles(t).validPtsCurr;
        end
        
    end
    hold off;
    drawnow;
    pause(0.001);
end