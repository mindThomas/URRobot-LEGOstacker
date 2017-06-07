function [ rgiImage ] = RGB2RGI( rgbImage )
%% Change To The Normalized RGB Color Representation (sec. 3.2.3 in IVIP book)
% Furthermore if a pixel has a value of 255 in just one of the color channels
% then there is a risk that the pixel was saturated in the color channel
% with a value of 255 in the image acquisition process. This could lead to
% falls interpretation of the color later in the image processing, and
% should thus be discarded. (p. 59 top)
% Example: An rgb pixel with values of (255, 250, 250) would be interpretted 
% as white, but could have real values of (10000, 250, 250) = red. 
% Thus we put such pixel to (0,0,0) = black

tmpRGBImage = double(rgbImage); % should we use double or single
tmpR = tmpRGBImage(:,:,1);
tmpG = tmpRGBImage(:,:,2); 
tmpB = tmpRGBImage(:,:,3);
    
% The actual tranformation
for n = 1:size(tmpR,1);
    for m = 1:size(tmpR,2);
        if (tmpR(n,m)==255 || tmpG(n,m)==255 || tmpB(n,m)==255) % maybe saturated => ignored!
            tmpR_new(n,m) = 0;
            tmpG_new(n,m) = 0;
            tmpB_new(n,m) = 0;
            tmpI(n,m) = 0;
        else % Change To The Normalized RGB Color Representation
            tmpR_new(n,m) = tmpR(n,m)/(tmpR(n,m)+tmpG(n,m)+tmpB(n,m))*255; % formula 3.5
            tmpG_new(n,m) = tmpG(n,m)/(tmpR(n,m)+tmpG(n,m)+tmpB(n,m))*255; % formula 3.5
            tmpB_new(n,m) = tmpB(n,m)/(tmpR(n,m)+tmpG(n,m)+tmpB(n,m))*255; % formula 3.5
            tmpI(n,m) = (tmpR(n,m)+tmpG(n,m)+tmpB(n,m))/3; % below formula 3.6 (intensity) 
        end
	end
end

% RGI image
tmpRGBImage_norm = tmpR_new;
tmpRGBImage_norm(:,:,2) = tmpG_new;
tmpRGBImage_norm(:,:,3) = tmpI;
    
rgiImage = uint8(tmpRGBImage_norm); % back to 8 bit

end

