function [ rgiImage ] = RGB2RGI2( rgbImage )
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
tmpRGBImage_norm = zeros(size(rgbImage));
tmpR = tmpRGBImage(:,:,1);
tmpG = tmpRGBImage(:,:,2); 
tmpB = tmpRGBImage(:,:,3);
tmpSum = tmpR+tmpG+tmpB;

rSat = find(tmpR==255);
gSat = find(tmpG==255);
bSat = find(tmpB==255);
tmpR(rSat) = 0; tmpR(gSat) = 0; tmpR(bSat) = 0;
tmpG(rSat) = 0; tmpG(gSat) = 0; tmpG(bSat) = 0;
%tmpB(rSat) = 0; tmpB(gSat) = 0; tmpB(bSat) = 0;

tmpR = tmpR ./ tmpSum;
tmpG = tmpG ./ tmpSum;
%tmpB = tmpB ./ tmpSum;   

% RGI image
tmpRGBImage_norm(:,:,1) = 255 * tmpR;
tmpRGBImage_norm(:,:,2) = 255 * tmpG;
tmpRGBImage_norm(:,:,3) = tmpSum ./ 3; % intensity
    
rgiImage = uint8(tmpRGBImage_norm); % back to 8 bit

end

