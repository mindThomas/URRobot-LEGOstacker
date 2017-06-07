function [ binaryImage ] = colorThresholding( rgiImage,config )

I_treshold_min = config.I_treshold_min;
R_threshold_min = config.red_min;
R_threshold_max = config.red_max;
G_threshold_min = config.green_min;
G_threshold_max = config.green_max;

%% Color Thresholding (sec. 4.4.1 in IVIP book)
% Furthermore also intensity thresholding is performed in this step. 
% Meaning that values close to (0,0,0) in the color cube 
% are put to (0,0,0).
% When a pixel is close to (0,0,0) "it is hard to distinguish colors" (p. 58 bottom)
% This coresponds to I = (R+G+B)/3 << 1

    for n = 1:size(rgiImage,1);
        for m = 1:size(rgiImage,2);
            if  rgiImage(n,m,3) < I_treshold_min % hard to distinguish colors => ignored!
                tmp_binary_img(n,m) = 0;
            else 
                  if  ((rgiImage(n,m,1) > R_threshold_min && rgiImage(n,m,1) < R_threshold_max)...
                       && (rgiImage(n,m,2) > G_threshold_min && rgiImage(n,m,2) < G_threshold_max)) 
                   
                    tmp_binary_img(n,m) = 1;
                else
                    tmp_binary_img(n,m) = 0;
                end
            end
        end
    end
    
    binaryImage = tmp_binary_img;

end

