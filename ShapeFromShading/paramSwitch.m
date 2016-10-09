function [param1_out,param2_out] = paramSwitch(param1,param2,type )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    p = param1; q = param2;
    f = param1; g = param2;
    param1size = size(param1);
    %pq to fg
    if strcmp(type,'pq') 
        if (param1size(1)>1)
            tanPQ = (p.^2+q.^2).^(0.5);
            f = 2.*p./(1+(1+p.^2+q.^2).^(0.5));
            g = 2.*q./(1+(1+p.^2+q.^2).^(0.5));
        else
            tanPQ = (p.^2 + q.^2).^0.5;
            tanFG = tan(0.5.*arctan(tanPQ));
            f = 2.*p.*tanFG./tanPQ;
            g = 2.*q.*tanFG./tanPQ;
        end
    param1_out = f;
    param2_out = g;
    
    %fg to pq
    else
        f = param1;
        g = param2;  
        threshold = 1.5;
        if (param1size(1)>1)
            denImage = 4-f.^2-g.^2;
            p = 4.*f./denImage;
            q = 4.*g./denImage;
        else
            p = 4.*f./(4-f.^2-g.^2);
            q = 4.*g./(4-f.^2-g.^2);
        end
    param1_out = p;
    param2_out = q;
    end
end

