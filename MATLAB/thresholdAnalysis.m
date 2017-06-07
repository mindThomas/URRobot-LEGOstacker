function [ ] = thresholdAnalysis(rgbImage, RB_config,GB_config,BB_config,YB_config,WB_config,OB_config  )

[ rgiImage ] = RGB2RGI2( rgbImage );

%% Analysis of the threshold values
% This is performed by taking upper and lower thresholds equal to a
% predefined upper and lower percentiles of values in the red and green
% color channels of the normalized (RGI-)image!

%% The colour diffinitions
% Since we have transformed to RGI image, and do not care about the light
% intensity, we only need to define thresholds for Red and Green.
% Threshold values is found by looking at the color histogram of an image
% color normalized picture cropped to fit one brick

% Red Brick
fig = figure;
title('Mark Red Brick, right-click and press "crop image"')
hold on
[RB_im, RB_pos] = imcrop(rgbImage);
close(fig)

RB_pos = round(RB_pos);

RB_red_min = prctile(reshape(rgiImage(RB_pos(2):RB_pos(2)+RB_pos(4),RB_pos(1):RB_pos(1)+RB_pos(3),1),1,[]),RB_config.LowerPrcTile);
RB_red_max = prctile(reshape(rgiImage(RB_pos(2):RB_pos(2)+RB_pos(4),RB_pos(1):RB_pos(1)+RB_pos(3),1),1,[]),RB_config.upperPrcTile);
RB_green_min = prctile(reshape(rgiImage(RB_pos(2):RB_pos(2)+RB_pos(4),RB_pos(1):RB_pos(1)+RB_pos(3),2),1,[]),RB_config.LowerPrcTile);
RB_green_max = prctile(reshape(rgiImage(RB_pos(2):RB_pos(2)+RB_pos(4),RB_pos(1):RB_pos(1)+RB_pos(3),2),1,[]),RB_config.upperPrcTile);

RB_mass = RB_pos(4)*RB_pos(3);


% Green Brick
fig = figure;
title('Mark Green Brick, right-click and press "crop image"')
hold on
[GB_im, GB_pos] = imcrop(rgbImage);
close(fig)

GB_pos = round(GB_pos);

GB_red_min = prctile(reshape(rgiImage(GB_pos(2):GB_pos(2)+GB_pos(4),GB_pos(1):GB_pos(1)+GB_pos(3),1),1,[]),GB_config.LowerPrcTile);
GB_red_max = prctile(reshape(rgiImage(GB_pos(2):GB_pos(2)+GB_pos(4),GB_pos(1):GB_pos(1)+GB_pos(3),1),1,[]),GB_config.upperPrcTile);
GB_green_min = prctile(reshape(rgiImage(GB_pos(2):GB_pos(2)+GB_pos(4),GB_pos(1):GB_pos(1)+GB_pos(3),2),1,[]),GB_config.LowerPrcTile);
GB_green_max = prctile(reshape(rgiImage(GB_pos(2):GB_pos(2)+GB_pos(4),GB_pos(1):GB_pos(1)+GB_pos(3),2),1,[]),GB_config.upperPrcTile);

GB_mass = GB_pos(4)*GB_pos(3);

% Blue Brick
fig = figure;
title('Mark Blue Brick, right-click and press "crop image"')
hold on
[BB_im, BB_pos] = imcrop(rgbImage);
close(fig)

BB_pos = round(BB_pos);

BB_red_min = prctile(reshape(rgiImage(BB_pos(2):BB_pos(2)+BB_pos(4),BB_pos(1):BB_pos(1)+BB_pos(3),1),1,[]),BB_config.LowerPrcTile);
BB_red_max = prctile(reshape(rgiImage(BB_pos(2):BB_pos(2)+BB_pos(4),BB_pos(1):BB_pos(1)+BB_pos(3),1),1,[]),BB_config.upperPrcTile);
BB_green_min = prctile(reshape(rgiImage(BB_pos(2):BB_pos(2)+BB_pos(4),BB_pos(1):BB_pos(1)+BB_pos(3),2),1,[]),BB_config.LowerPrcTile);
BB_green_max = prctile(reshape(rgiImage(BB_pos(2):BB_pos(2)+BB_pos(4),BB_pos(1):BB_pos(1)+BB_pos(3),2),1,[]),BB_config.upperPrcTile);

BB_mass = BB_pos(4)*BB_pos(3);

% yellow Brick
fig = figure;
title('Mark Yellow Brick, right-click and press "crop image"')
hold on
[YB_im, YB_pos] = imcrop(rgbImage);
close(fig)

YB_pos = round(YB_pos);

YB_red_min = prctile(reshape(rgiImage(YB_pos(2):YB_pos(2)+YB_pos(4),YB_pos(1):YB_pos(1)+YB_pos(3),1),1,[]),YB_config.LowerPrcTile);
YB_red_max = prctile(reshape(rgiImage(YB_pos(2):YB_pos(2)+YB_pos(4),YB_pos(1):YB_pos(1)+YB_pos(3),1),1,[]),YB_config.upperPrcTile);
YB_green_min = prctile(reshape(rgiImage(YB_pos(2):YB_pos(2)+YB_pos(4),YB_pos(1):YB_pos(1)+YB_pos(3),2),1,[]),YB_config.LowerPrcTile);
YB_green_max = prctile(reshape(rgiImage(YB_pos(2):YB_pos(2)+YB_pos(4),YB_pos(1):YB_pos(1)+YB_pos(3),2),1,[]),YB_config.upperPrcTile);

YB_mass = YB_pos(4)*YB_pos(3);

% Orange Brick
fig = figure;
title('Mark Orange Brick, right-click and press "crop image"')
hold on
[OB_im, OB_pos] = imcrop(rgbImage);
close(fig)

OB_pos = round(OB_pos);

OB_red_min = prctile(reshape(rgiImage(OB_pos(2):OB_pos(2)+OB_pos(4),OB_pos(1):OB_pos(1)+OB_pos(3),1),1,[]),OB_config.LowerPrcTile);
OB_red_max = prctile(reshape(rgiImage(OB_pos(2):OB_pos(2)+OB_pos(4),OB_pos(1):OB_pos(1)+OB_pos(3),1),1,[]),OB_config.upperPrcTile);
OB_green_min = prctile(reshape(rgiImage(OB_pos(2):OB_pos(2)+OB_pos(4),OB_pos(1):OB_pos(1)+OB_pos(3),2),1,[]),OB_config.LowerPrcTile);
OB_green_max = prctile(reshape(rgiImage(OB_pos(2):OB_pos(2)+OB_pos(4),OB_pos(1):OB_pos(1)+OB_pos(3),2),1,[]),OB_config.upperPrcTile);

OB_mass = OB_pos(4)*OB_pos(3);

% % White Brick
% fig = figure;
% title('Mark White Brick, right-click and press "crop image"')
% hold on
% [WB_im, WB_pos] = imcrop(rgbImage);
% close(fig)
% 
% WB_pos = round(WB_pos);
% 
% WB_red_min = prctile(reshape(rgiImage(WB_pos(2):WB_pos(2)+WB_pos(4),WB_pos(1):WB_pos(1)+WB_pos(3),1),1,[]),WB_config.LowerPrcTile);
% WB_red_max = prctile(reshape(rgiImage(WB_pos(2):WB_pos(2)+WB_pos(4),WB_pos(1):WB_pos(1)+WB_pos(3),1),1,[]),WB_config.upperPrcTile);
% WB_green_min = prctile(reshape(rgiImage(WB_pos(2):WB_pos(2)+WB_pos(4),WB_pos(1):WB_pos(1)+WB_pos(3),2),1,[]),WB_config.LowerPrcTile);
% WB_green_max = prctile(reshape(rgiImage(WB_pos(2):WB_pos(2)+WB_pos(4),WB_pos(1):WB_pos(1)+WB_pos(3),2),1,[]),WB_config.upperPrcTile);
% 
% WB_mass = WB_pos(4)*WB_pos(3);

%% minimum mass calculation

%mass_min = min([RB_mass,GB_mass,BB_mass,YB_mass,WB_mass,OB_mass]);
mass_min = min([RB_mass,GB_mass,BB_mass,YB_mass,OB_mass]);


%% save variables for late use
save('thresholds.mat','RB_red_min','RB_red_max','RB_green_min','RB_green_max',...
                      'GB_red_min','GB_red_max','GB_green_min','GB_green_max',...
                      'BB_red_min','BB_red_max','BB_green_min','BB_green_max',...
                      'YB_red_min','YB_red_max','YB_green_min','YB_green_max',...
                      'OB_red_min','OB_red_max','OB_green_min','OB_green_max',...                      
                      'mass_min');%'WB_red_min','WB_red_max','WB_green_min','WB_green_max',...


end

