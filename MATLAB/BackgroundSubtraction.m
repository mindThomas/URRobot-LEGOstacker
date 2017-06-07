function [ Foreground ] = BackgroundSubtraction( rgiImage,BG_threshold )
%% Background Subtraction
BGImageRGB = imread('backgroundImage.bmp');
BGImageRGI = RGB2RGI2( BGImageRGB );

% do we want to remove background intesity 
F_abs = abs(int32(rgiImage(:,:,1:3)) - int32(BGImageRGI(:,:,1:3)));
FG_pixelsR = (F_abs(:,:,1) > BG_threshold); % foregrounds pixels = 1's for the red channel
FG_pixelsG = (F_abs(:,:,2) > BG_threshold); % foregrounds pixels = 1's for the green channel
FG_pixelsI = (F_abs(:,:,3) > BG_threshold); % foregrounds pixels = 1's for the intenisty channel
% matrix with ones everywhere the F_abs is bigger than a treshold (the foreground pixels)

FG_pixels = uint8(FG_pixelsR | FG_pixelsG | FG_pixelsI); 
% only assume backgound pixel if all channels is below the threshold

Foreground(:,:,1) = rgiImage(:,:,1).*FG_pixels; % only the foreground is kept
Foreground(:,:,2) = rgiImage(:,:,2).*FG_pixels;
Foreground(:,:,3) = rgiImage(:,:,3).*FG_pixels;

end

