function [depthNCC,depthSAD,depthSSD] = stereo2(v0,v1,windowSize, disp_max)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[M,N] = size(v0);


depthNCC = zeros(size(v0));
depthSAD = zeros(size(v0));
depthSSD = zeros(size(v0));

k_max = (windowSize -1)/2;
k_range = -k_max:k_max;
for i =1+k_max:M - k_max  
    for j = 1+k_max:N-k_max
      
            corr_max = 0;
            sad_min = Inf;
            ssd_min = Inf;
            for k = 0:disp_max
                curr_sad = 0;
                curr_ssd = 0;
                curr_corr = 0;
                
                if(j+k_max+k <= N)
                    a = v1(i+k_range,j+k_range);
                    b = v0(i+k_range,j+k+k_range);
%                     curr_corr = corr2(a,b);
                    num = sum(sum(a.*b));
                    den1 = sum(sum(a.^2));
                    den2 = sum(sum(b.^2));
                    curr_corr = num/sqrt(den1*den2);
                    curr_sad  = sum(sum(abs(a-b)));
                    curr_ssd  = sum(sum((a-b).^2));
                end
                if(curr_corr>corr_max)
                    corr_max = curr_corr;
                    depthNCC(i,j) = k;
                end
                
                if(curr_sad<sad_min)
                    sad_min = curr_sad;
                    depthSAD(i,j) = k;
                end
                                
                if(curr_ssd<ssd_min)
                    ssd_min = curr_ssd;
                    depthSSD(i,j) = k;
                end
        end
%         disp(['i = ',num2str(i),' j = ',num2str(j)]);
    end
end


end

