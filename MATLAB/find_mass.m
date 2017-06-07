function [ mass ] = find_mass( obj,image )
    mass = 0;
    for n = 1:size(image,1)
        for m = 1:size(image,2)
            if image(n,m) == obj
                mass = mass + 1;
            end
        end
    end
end

