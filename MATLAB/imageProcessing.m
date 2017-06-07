function [ brickInfo ] = imageProcessing( rgiImage, config )
%% Color Thresholding (sec. 4.4.1 in IVIP book)
binaryImage = colorThresholding(rgiImage,config);

%% Remove noise in image 
% Neighborhood processing - Morphology (chapter 6 in IVIP book)
binaryImageNoiseFree = removeNoise( binaryImage,config);

%% BLOB Analysis
brickInfo = blobAnalysis(binaryImageNoiseFree,config); % Returns cell array with 
                                                        % information of each brick 
                                                        % in the given color
                                                        
saveImages(config,binaryImage,binaryImageNoiseFree,brickInfo)
                                                        
end

