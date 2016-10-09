clear all

%img = imread('img1.jpg');
%parameters
inputType = 'sphere';
paramType = 'pq';
img1 = imread('img1.jpg');
img1 = mat2gray(rgb2gray(double(img1)));
src = [0,0,1]; 			 
lambda = 1000;		%regularization		 
noiseRad = 0;   	     
noiseSrc = 0; 	              
nSFSiter = 500;	%no. of iterations for shape from shading			
nDepthIter = 500;  %no. of iterations for depth estimation			


% if(strcmp(inputType,'sphere'))
%     if(strcmp(paramType,'pq'))
%          depth = sphere_main_pq(src,lambda,noiseRad,noiseSrc,nSFSiter,nDepthIter);
%     else if (strcmp(paramType,'fg'))
%          depth = sphere_main_fg(src,lambda,noiseRad,noiseSrc,nSFSiter,nDepthIter);
%         end
%     end
% else if(strcmp(inputType,'image'))  
%        if(strcmp(paramType,'pq'))
%          depth = img_main_pq(img1,src,lambda,noiseRad,noiseSrc,nSFSiter,nDepthIter);
%        else if (strcmp(paramType,'fg'))
%          depth =img_main_fg(img1,src,lambda,noiseRad,noiseSrc,nSFSiter,nDepthIter);
%            end
%        end
%      end
% end

% lambdaArray = [1,10,100,1000,10000];
% noiseRadArray = [0,0.1,0.5,1,2];
% noiseSrcArray = [0,0.1,0.2,0.35,0.5];
% 
% for i = 1:5
%     noiseSrc = noiseSrcArray(i);
%     for j = 1:5
%         noiseRad = noiseRadArray(j);
%         for k = 1:5
%         
%         lambda = lambdaArray(k);
% 
% depthPQsphere = sphere_main_pq(src,lambda,noiseRad,noiseSrc,nSFSiter,nDepthIter);
% name = strcat('SpherePQ',' NoiseRad=',num2str(noiseRad),' NoiseSrc=',num2str(noiseSrc),' lambda=',num2str(lambda));
% figure;
% imagesc(depthPQsphere);
% title(name);
% axis on;
% saveas(gcf,strcat('results/sphere(2d)/',name,'.jpg'));
% close(gcf);
% 
% figure;
% surf(depthPQsphere);
% axis on;title(name);
% saveas(gcf,strcat('results/sphere(3d)/',name,'.jpg'));
% close(gcf);
% 
% depthFGsphere = sphere_main_fg(src,lambda,noiseRad,noiseSrc,nSFSiter,nDepthIter);
% name = strcat('SphereFG',' NoiseRad=',num2str(noiseRad),' NoiseSrc=',num2str(noiseSrc),' lambda=',num2str(lambda));
% figure;
% imagesc(depthFGsphere);
% title(name);
% axis on;
% saveas(gcf,strcat('results/sphere(2d)/',name,'.jpg'));
% close(gcf);
% 
% figure;
% surf(depthFGsphere);
% axis on;title(name);
% saveas(gcf,strcat('results/sphere(3d)/',name,'.jpg'));
% close(gcf);
% 
%         end
%     end
% end

lambdaArray = [1,10,100,1000,10000];
noiseRadArray = [0,0.1,0.5,1,2];
noiseSrcArray = [0,0.1,0.2,0.35,0.5];

for k = 1:5
    
  noiseRad = 0; noiseSrc = noiseSrcArray(k);
 lambda = 1000;
depthPQsphere = sphere_main_pq(src,lambda,noiseRad,noiseSrc,nSFSiter,nDepthIter);
name = strcat('SpherePQ',' NoiseRad=',num2str(noiseRad),' NoiseSrc=',num2str(noiseSrc),' lambda=',num2str(lambda));
figure;
imagesc(depthPQsphere);
title(name);
axis on;
saveas(gcf,strcat('results/demoSrc/sphere(2d)/',name,'.jpg'));
close(gcf);

figure;
surf(depthPQsphere);
axis on;title(name);
saveas(gcf,strcat('results/demoSrc/sphere(3d)/',name,'.jpg'));
close(gcf);

depthFGsphere = sphere_main_fg(src,lambda,noiseRad,noiseSrc,nSFSiter,nDepthIter);
name = strcat('SphereFG',' NoiseRad=',num2str(noiseRad),' NoiseSrc=',num2str(noiseSrc),' lambda=',num2str(lambda));
figure;
imagesc(depthFGsphere);
title(name);
axis on;
saveas(gcf,strcat('results/demoSrc/sphere(2d)/',name,'.jpg'));
close(gcf);

figure;
surf(depthFGsphere);
axis on;title(name);
saveas(gcf,strcat('results/demoSrc/sphere(3d)/',name,'.jpg'));
close(gcf);

end



lambda = 1000; noiseRad = 0; noiseSrc = 0; 
depthPQImage = img_main_pq(img1,src,lambda,noiseRad,noiseSrc,nSFSiter,nDepthIter);
name = strcat('ImagePQ',' NoiseRad=',num2str(noiseRad),' NoiseSrc=',num2str(noiseSrc),' lambda=',num2str(lambda));
figure;
imagesc(depthPQImage);
title(name);
axis on;
saveas(gcf,strcat('results/customImage(2d)/',name,'.jpg'));

figure;
surf(depthPQImage);view([124,74]);
axis on;title(name);
saveas(gcf,strcat('results/customImage(3d)/',name,'.jpg'));


depthFGImage = img_main_fg(img1,src,lambda,noiseRad,noiseSrc,nSFSiter,nDepthIter);
name = strcat('ImageFG',' NoiseRad=',num2str(noiseRad),' NoiseSrc=',num2str(noiseSrc),' lambda=',num2str(lambda));
figure;
imagesc(depthFGImage);
title(name);
axis on;
saveas(gcf,strcat('results/customImage(2d)/',name,'.jpg'));

figure;
surf(depthFGImage);view([124,74]);
axis on;title(name);
saveas(gcf,strcat('results/customImage(3d)/',name,'.jpg'));





