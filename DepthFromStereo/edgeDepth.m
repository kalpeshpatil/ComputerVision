

%using edge features and then interpolation

lambda = 100;
[edge_depth1NCC,edge_depth1SAD,edge_depth1SSD] = stereo(v2,v3,windowSize, disp_max);
depth1NCC_edged = spread_depth(edge_depthNCC,v2,v3,lambda);
depth1SAD_edged = spread_depth(edge_depthSAD,v2,v3,lambda);
depth1SSD_edged = spread_depth(edge_depthSSD,v2,v3,lambda);

depth1SAD_edged(:,409:end) = 0;
depth1SSD_edged(:,409:end) = 0;


%using edge features and then interpolation
lambda = 100;
[edge_depth2NCC,edge_depth2SAD,edge_depth2SSD] = stereo(v1,v3,windowSize, 2*disp_max);
depth2NCC_edged = spread_depth(edge_depth2NCC,v1,v3,lambda);
depth2SAD_edged = spread_depth(edge_depth2SAD,v1,v3,lambda);
depth2SSD_edged = spread_depth(edge_depth2SSD,v1,v3,lambda);

%using edge features and then interpolation
lambda = 100;
[edge_depth3NCC,edge_depth3SAD,edge_depth3SSD] = stereo(v0,v3,windowSize, 3*disp_max);
depth3NCC_edged = spread_depth(edge_depth3NCC,v0,v3,lambda);
depth3SAD_edged = spread_depth(edge_depth3SAD,v0,v3,lambda);
depth3SSD_edged = spread_depth(edge_depth3SSD,v0,v3,lambda);

%multi occular

depthMultiNCC_edged = (depth1NCC_edged + depth2NCC_edged/2 + depth3NCC_edged/3)/3;
depthMultiSAD_edged = (depth1SAD_edged + depth2SAD_edged/2 + depth3SAD_edged/3)/3;
depthMultiSSD_edged = (depth1SSD_edged + depth2SSD_edged/2 + depth3SSD_edged/3)/3;

depthMultiNCC_edged(:,374:end) = depth1NCC_edged(:,374:end);
depthMultiSAD_edged(:,374:end) = depth1SAD_edged(:,374:end);
depthMultiSSD_edged(:,374:end) = depth1SSD_edged(:,374:end);




