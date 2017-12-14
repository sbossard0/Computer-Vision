function quantize(x,L,min,max)
    %Compute steps and put in array
    stepUnrounded = (max - min)/L;
    step = round(stepUnrounded);
    
    steps = [min];
    for i = 1 : L
        steps(end+1) = steps(end) + step;
    end    
    disp("There are " + L + " levels.");
    disp("Step size = " + step);        
    
    for j = 1 : size(x,1)
        u = uint8(x);
        if u <= steps(1)
             u = steps(1);  
        elseif u > steps(L)
             u = steps(L);
        else
            for k = 1 : L
                if u >= steps(k) && u < steps(k+1)
                    u = steps(k);
                end
            end
        end
        disp(u); 
    end
end
