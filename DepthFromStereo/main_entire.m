% Kalpesh Patil (130040019)
% Mredul Sarda (130020020)
% EE702: Assignment 2: Stereo

tic;

v0 = imread('data/view0.png');
v1 = imread('data/view1.png');
v2 = imread('data/view2.png');
v3 = imread('data/view3.png');
v4 = imread('data/view4.png');
v5 = imread('data/view5.png');

v0 = double(rgb2gray(v0));
v1 = double(rgb2gray(v1));
v2 = double(rgb2gray(v2));
v3 = double(rgb2gray(v3));
v4 = double(rgb2gray(v4));
v5 = double(rgb2gray(v5));


windowSize = 7;
disp_max = 16;

%full image method

[depth1NCC,depth1SAD,depth1SSD] = stereo2(v2,v3,windowSize, disp_max);
depth1SAD(:,409:end) = 0;
depth1SSD(:,409:end) = 0;
[depth2NCC,depth2SAD,depth2SSD] = stereo2(v1,v3,windowSize, 2*disp_max);
[depth3NCC,depth3SAD,depth3SSD] = stereo2(v0,v3,windowSize, 3*disp_max);

depthMultiNCC = (depth1NCC + depth2NCC/2 + depth3NCC/3)/3;
depthMultiSAD = (depth1SAD + depth2SAD/2 + depth3SAD/3)/3;
depthMultiSSD = (depth1SSD + depth2SSD/2 + depth3SSD/3)/3;


depthMultiNCC(:,374:end) = depth1NCC(:,374:end);
depthMultiSAD(:,374:end) = depth1SAD(:,374:end);
depthMultiSSD(:,374:end) = depth1SSD(:,374:end);

saveresults;


%using edge features
edgeDepth;
saveEdgeResults;

toc;
