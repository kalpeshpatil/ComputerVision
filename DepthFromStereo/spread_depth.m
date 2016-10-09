function [ depth ] = spread_depth(depth_edge,v0,v1,lambda)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
	disp_max = 16;
    iters = 500;
    depth_mask = (depth_edge >0);
    [M,N] = size(v0);
   
   v0x = zeros(size(v0));
   for i = 2:M-1
      for j = 2:N-1
          v0x(i,j) = abs(v0(i,j+1) - v0(i,j-1))*0.5;
      end
   end
   
   depth_new = depth_edge;   
   depth = depth_new;
   
	for k=1:iters,
		for i=2:M-1,
    		for j=2:N-disp_max
				if(~depth_mask(i,j))
                     t = round(depth(i,j));
					 depth_bar = (depth(i,j+1) + depth(i,j-1) + depth(i+1,j) + depth(i-1,j))/4;
                     depth_new(i,j)= min(depth_bar + ((v1(i,j)-v0(i,j+t))*v0x(i,t+j))/lambda,disp_max);
                     depth_new(i,j)= max(depth_new(i,j),0);
                     depth_new(i,j) = depth_bar;
                end	
	        end
        end
        depth = depth_new;
        
    end
   
end


