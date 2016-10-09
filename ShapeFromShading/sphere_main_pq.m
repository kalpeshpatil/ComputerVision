function [depthEst] = sphere_main_pq(src,lambda,noiseRad,noiseSrc,nSFSiter,nDepthIter)
%generates a sphere
%calculates p,q parameters from generated sphere
%radiance is calculated from p,q
%p,q is then estimated from radiance and later depth is estimated

%params for sphere
radiusToImage = 0.25;	       %radius
imgSize = 100;                   %size of sphere image   

%generating sphere

depth = zeros(imgSize,imgSize);
depthClip = zeros(imgSize,imgSize);
roi = zeros(imgSize,imgSize);
R = radiusToImage*imgSize;
Rclipped = R*0.98;
[X,Y] = meshgrid(1:imgSize,1:imgSize);

%finding depth
depth = R^2 - (X - imgSize/2).^2 - (Y - imgSize/2).^2;
roi = depth>0;
depth = depth.*roi;
depth = sqrt(depth);

%removing boundaries 
roi = (Rclipped^2 - (X - imgSize/2).^2 - (Y - imgSize/2).^2)>0;
depth = depth.*roi;

%finding gradient
p = zeros(imgSize, imgSize);
q = zeros(imgSize, imgSize);
   for i = 2:imgSize-1
      for j = 2:imgSize-1
          p(i,j) = (depth(i,j+1) - depth(i,j-1))*0.5;
          q(i,j) = (depth(i+1,j) - depth(i-1,j))*0.5;
      end
   end
p = p.*roi;
q = q.*roi;

%adding noise to src
src = src + rand(1,3)*noiseSrc;


%finding radiance at every point
rad = zeros(imgSize,imgSize);
rad = (p.*src(1)+q.*src(2)+1)./(((src(1)^2+src(2)^2+1)^0.5)*((p.^2+q.^2+1).^0.5));
rad = rad.*roi;

%boundary
boundary         = zeros(imgSize,imgSize);
roiRad = rad > 0;
kernel   = ones(3,3);
boundary = roiRad - imerode(roiRad,kernel,5);
boundary = imerode(imdilate(boundary,kernel,3),kernel,3); 
roiNew   = roi.*roiRad;
p = p.*roiNew;
q = q.*roiNew;



rad = rad + rand(imgSize,imgSize).*noiseRad;


%finding p,q at boundary
dx = rad;
dy = rad;
dx(:,2:imgSize-1) = (dx(:,3:imgSize) - dx(:,1:imgSize-2))*0.5;
dy(2:imgSize-1,:) = (-dy(1:imgSize-2,:) + dy(3:imgSize,:))*0.5;
pBoundary = dx.*boundary;
qBoundary = dy.*boundary;
 

%estimating p,q
p_next = pBoundary;
q_next = qBoundary;
p_est = pBoundary;
q_est = qBoundary;

%using assumed src
src = [0,0,1];

for l = 2:nSFSiter-1
    for i = 2:imgSize-1
        for j = 1:imgSize
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

Zp = zeros(imgSize,imgSize);
Z = zeros(imgSize,imgSize);
p_x = p_est; 
q_y = q_est;
p_x(:,2:imgSize-1) = (p_x(:,3:imgSize) - p_x(:,1:imgSize-2))*0.5;
q_y(2:imgSize-1,:) = (q_y(3:imgSize,:) - q_y(1:imgSize-2,:))*0.5;

for k = 1:nDepthIter
    for i = 1:imgSize
        for j=1:imgSize
            if(roiRad(i,j))
                Z(i,j)=0.25*(Zp(i-1,j)+Zp(i+1,j)+Zp(i,j-1)+Zp(i,j+1))+abs(p_x(i,j))+abs(q_y(i,j));
            end

        end
    end
    Zp = roiRad.*Z;
end
depthEst = roiRad.*Z;
end

