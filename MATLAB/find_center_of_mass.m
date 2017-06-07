function [ coordinates ] = find_center_of_mass( obj,image )
    x = 0;
    y = 0;
    N_x = 0;
    N_y = 0;
    for n = 1:size(image,1)
        for m = 1:size(image,2)
            if image(n,m) == obj
                    x = x + m;
                    y = y + n;
                    N_x = N_x + 1;
                    N_y = N_y + 1;
            end
        end
    end
    
    x = x/N_x;
    y = y/N_y;
    
    coordinates = round([x y]);
end