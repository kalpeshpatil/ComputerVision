function [depthEst] = img_main_pq(img1,src,lambda,noiseRad,noiseSrc,nSFSiter,nDepthIter)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

img1 = mat2gray(img1);
img1 = imresize(img1,0.1);
rad = img1;
imgSize = size(rad);
imgSize1 = imgSize(1);
imgSize2 = imgSize(2);

boundary    = zeros(imgSize1,imgSize2);
roiRad = rad > 0;
kernel   = ones(3,3);
boundary = roiRad - imerode(roiRad,kernel,5);
boundary = imerode(imdilate(boundary,kernel,3),kernel,3); 

%adding noise
rad = rad + rand(imgSize1,imgSize2).*noiseRad;
src = src + rand(1,3)*noiseSrc;

%finding p,q at boundary
dx = rad;
dy = rad;
dx(:,2:imgSize2-1) = (dx(:,3:imgSize2) - dx(:,1:imgSize2-2))*0.5;
dy(2:imgSize1-1,:) = (-dy(1:imgSize1-2,:) + dy(3:imgSize1,:))*0.5;
pBoundary = dx.*boundary;
qBoundary = dy.*boundary;

%estimating p,q
p_next = pBoundary;
q_next = qBoundary;
p_est = pBoundary;
q_est = qBoundary;

for l = 2:nSFSiter-1
    for i = 2:imgSize1-1
        for j = 2:imgSize2-1
            if(roiRad(i,j))
            radx = 0; rady =0;
            temp_rad =(p_est(i,j)*src(1)+q_est(i,j)*src(2)+1)/(((src(1)^2+src(2)^2+1)^0.5)*((p_est(i,j)^2+q_est(i,j)^2+1)^0.5));
            radx = (p_est(i,j)^2*src(1)+src(1)-q_est(i,j)*q_est(i,j)*src(2)-p_est(i,j))/(((src(1)^2+src(2)^2+1)^0.5)*(p_est(i,j)^2+(q_est(i,j)^2+1)^0.5)^3);
            rady = (q_est(i,j)^2*src(1)+src(1)-p_est(i,j)*p_est(i,j)*src(2)-q_est(i,j))/(((src(1)^2+src(2)^2+1)^0.5)*(p_est(i,j)^2+(q_est(i,j)^2+1)^0.5)^3);
            p_next(i,j)=0.25*(p_est(i-1,j)+p_est(i+1,j)+p_est(i,j-1)+p_est(i,j+1))-1/lambda *(rad(i,j)-temp_rad)*radx;
            q_next(i,j)=0.25*(q_est(i-1,j)+q_est(i+1,j)+q_est(i,j-1)+q_est(i,j+1))-1/lambda *(rad(i,j)-temp_rad)*rady;
            end
        end
    end    
    p_est=(p_next.*roiRad.*(1-boundary))+pBoundary.*boundary.*roiRad;
    q_est=(q_next.*roiRad.*(1-boundary))+qBoundary.*boundary.*roiRad;    
end

%getting depth from estimated p,q

Zp = zeros(imgSize1,imgSize2);
Z = zeros(imgSize1,imgSize2);
p_x = p_est; 
q_y = q_est;
p_x(:,2:imgSize2-1) = (p_x(:,3:imgSize2) - p_x(:,1:imgSize2-2))*0.5;
q_y(2:imgSize1-1,:) = (q_y(3:imgSize1,:) - q_y(1:imgSize1-2,:))*0.5;

for k = 1:nDepthIter
    for i = 2:imgSize1-1
        for j=2:imgSize2-1
            if(roiRad(i,j))
                Z(i,j)=0.25*(Zp(i-1,j)+Zp(i+1,j)+Zp(i,j-1)+Zp(i,j+1))+abs(p_x(i,j))+abs(q_y(i,j));
            end

        end
    end
    Zp = roiRad.*Z;
end
depthEst = roiRad.*Z;
end



