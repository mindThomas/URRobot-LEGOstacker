function [ binaryImageNoiseFree ] = removeNoise( binaryImage,config)
%% Neighborhood processing - Morphology (chapter 6 in IVIP book)
% We want to remove noise in the binary images. 
% To do so we using two compound operations: 
% First we make a closing and then opening (section 6.3.3 in IVIP book)

% Closing means to make a Dilation followed by an Erosion
% Opening means to make a Erosion followed by an Dilation

% Dilation: applying hit to all pixels
    % Hit: 
        % - for all 1s in the kernel we check if the pixel underneath is 1
        % - If this is the case for just one of the 1s, we put the pixel in
        % focus to a 1, else 0.
% Erosion: applying fit to all pixels
    % Fit: 
        % - for all 1s in the kernel we check if the pixel underneath is 1
        % - If this is the case for ALL of the 1s, we put the pixel in
        % focus to a 1, else 0.

% - In morphology, the kernel is denoted a structuring element and contains ?0?s and ?1?s.
% - In general a box-shaped structuring element tends to preserve sharp
% object corners (which we have in our makers)! 

% Size of structuring element for an opening operation should fit into the 
% smallest object to keep!

R_closing = config.R_closing;
R_opening = config.R_opening;

SE_closing = strel('rectangle',[R_closing R_closing]);
SE_opening = strel('rectangle',[R_opening R_opening]);

% closing
binaryImage_tmp = imclose(binaryImage,SE_closing);
% opening
binaryImage_tmp = imopen(binaryImage_tmp,SE_opening);

% It does not matter if there is a little noise left, since this can be
% removed by looking at the "mass" of each blob in the BLOBanalysis, 
% and just remove BLOBs with a to low "mass"

binaryImageNoiseFree = binaryImage_tmp;
end

