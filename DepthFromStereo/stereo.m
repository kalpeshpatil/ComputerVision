function [edge_depthNCC,edge_depthSAD,edge_depthSSD] = stereo(v0,v1,windowSize, disp_max)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[M,N] = size(v0);
edge0 = edge(v0,'canny');
edge1 = edge(v1,'canny');

edge_depthNCC = zeros(size(v0));
edge_depthSAD = zeros(size(v0));
edge_depthSSD = zeros(size(v0));

%corr_thresh = 0.7;
max_edge = 60;


k_max = (windowSize -1)/2;
k_range = -k_max:k_max;
for i =1+k_max:M - k_max-1  
    for j = 1+k_max:N-k_max-1 
        if(edge1(i,j))
            %corr_max = corr2(v0(i+k_range,j+k_range),v1(i+k_range,j+k_range));
            corr_max = 0;
            sad_min = Inf;
            ssd_min = Inf;
            for k = 0:disp_max
                if(j+k+disp_max <N)
                a = v1(i+k_range,j+k_range);
                b = v0(i+k_range,j+k+k_range);
                curr_corr = corr2(a,b);
                curr_sad  = sum(sum(abs(a-b)));
                curr_ssd  = sum(sum((a-b).^2));
                end
                if(curr_corr>corr_max)
                    corr_max = curr_corr;
                    edge_depthNCC(i,j) = k;
                end
                
                if(curr_sad<sad_min)
                    sad_min = curr_sad;
                    edge_depthSAD(i,j) = k;
                end
                                
                if(curr_ssd<ssd_min)
                    ssd_min = curr_ssd;
                    edge_depthSSD(i,j) = k;
                end
            end         
        end
%      disp(['i = ',num2str(i),' j = ',num2str(j)]);
    end
end


end

