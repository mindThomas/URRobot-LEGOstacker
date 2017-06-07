clear all;
clc;

KK = GetCameraCalibrationMatrix('calib/Calib_Results.mat');
Cal = load('calib/Calib_Results.mat', 'Tc_1');
CameraToObjectDistance = Cal.Tc_1(3);
clear Cal;

BackgroundCalibrationEnabled = true;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------------------- config  --------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

configStruct =  struct('I_treshold_min',uint8(20),...
                       'red_min',[],... %[x_min x_max y_min y_max]
                       'red_max',[],...
                       'green_min',[],...
                       'green_max',[],...
                       'R_closing',10,...
                       'R_opening',5,...
                       'LowerPrcTile',5,...
                       'upperPrcTile',95,...
                       'color',[],...
                       'mass_min',1000);
                   
                   
% Brick dimensions
BrickHeight = 19;
BrickWidth = 32;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


cam = webcam(2);
%cam.Resolution = '320x240';
%cam.Resolution = '800x600';
%cam.Resolution = '1280x720';
cam.Resolution = '1920x1080';
%cam.Resolution = '2304x1536';
cam.ExposureMode = 'manual';
cam.Exposure = -3;
cam.Focus = 0.2;

figure(1);
imshow(cam.snapshot);

%%
Robot_IP = '0.0.0.0';
robot = tcpip(Robot_IP,30000,'NetworkRole','server');
fclose(robot);
disp('Press Play on Robot...')
fopen(robot);
disp('Connected!');

%% Get initial pose
RobotInitialPose = readrobotpose(robot)
T = RobotInitialPose(1:3); % in mm
O = RobotInitialPose(4:6);

%% Move robot to camera picture location
CameraPicturePose = [485, -200, 450, pi, 0, 0];
moverobot(robot, 1, CameraPicturePose);
OpenGripper(robot);
if (BackgroundCalibrationEnabled)
    disp('Remove all bricks from table and prepare for background image.');
    pause
    rgbImage = snapshot(cam);
    imshow(rgbImage);
    imwrite(rgbImage, 'backgroundImage.bmp');
end

disp('Place brick in robot hand. Press enter and wait for closing');
pause
CloseGripper(robot);
ActivateCoopMode(robot);
disp('Place bricks on table with 0-angle alignment and Move robot on top of green brick');
disp('Press enter when done and clear');
pause
DeActivateCoopMode(robot);
pause(0.5);
GreenBrickPose = readrobotpose(robot);

MoveUpPose = GreenBrickPose;
MoveUpPose(3) = MoveUpPose(3) + 100;
moverobot(robot, 1, MoveUpPose);

%% Move robot to camera picture location
CameraPicturePose = [485, -200, 450, pi, 0, 0];
moverobot(robot, 1, CameraPicturePose);
%OpenGripper(robot);
pause(2);
rgbImage = snapshot(cam);
imshow(rgbImage);

disp('Calibrating based on image');

%% Setup Vision processing configuration                   
RB_config = configStruct;
GB_config = configStruct;
BB_config = configStruct;
YB_config = configStruct;
OB_config = configStruct;
WB_config = configStruct;
                   
RB_config = configStruct;
RB_config.name = 'Red';
GB_config = configStruct;
GB_config.name = 'Green';
BB_config = configStruct;
BB_config.name = 'Blue';
YB_config = configStruct;
YB_config.name = 'Yellow';
OB_config = configStruct;
OB_config.name = 'Orange';

WB_config = configStruct;
WB_config.name = 'White';



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------- analysis of threshold values  ---------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

choice = questdlg('Do you want to run color threshold analysis', ...
	'Choose action', ...
	'Yes','No','No');
% Handle response
switch choice
    case 'Yes'
        rgbImage = snapshot(cam);
        
        thresholdAnalysis(rgbImage,RB_config,GB_config,BB_config,YB_config,WB_config,OB_config);        
        load('thresholds.mat')
        disp('Done with analysis of threshold values!')
    case 'No'
        load('thresholds.mat')
        disp('Loaded color thresholds from file!')
end

RB_config.red_min = RB_red_min;
RB_config.red_max = RB_red_max;
RB_config.green_min = RB_green_min;
RB_config.green_max = RB_green_max;
clear RB_red_min RB_red_max RB_green_min RB_green_max

GB_config.red_min = GB_red_min;
GB_config.red_max = GB_red_max;
GB_config.green_min = GB_green_min;
GB_config.green_max = GB_green_max;
clear GB_red_min GB_red_max GB_green_min GB_green_max

BB_config.red_min = BB_red_min;
BB_config.red_max = BB_red_max;
BB_config.green_min = BB_green_min;
BB_config.green_max = BB_green_max;
clear BB_red_min BB_red_max BB_green_min BB_green_max

YB_config.red_min = YB_red_min;
YB_config.red_max = YB_red_max;
YB_config.green_min = YB_green_min;
YB_config.green_max = YB_green_max;
clear YB_red_min YB_red_max YB_green_min YB_green_max

% WB_config.red_min = WB_red_min;
% WB_config.red_max = WB_red_max;
% WB_config.green_min = WB_green_min;
% 
% WB_config.green_max = WB_green_max;
% clear WB_red_min WB_red_max WB_green_min WB_green_max

OB_config.red_min = OB_red_min;
OB_config.red_max = OB_red_max;
OB_config.green_min = OB_green_min;
OB_config.green_max = OB_green_max;
clear OB_red_min OB_red_max OB_green_min OB_green_max

mass_min = mass_min/3;
RB_config.mass_min = mass_min;
GB_config.mass_min = mass_min;
BB_config.mass_min = mass_min;
YB_config.mass_min = mass_min;
WB_config.mass_min = mass_min;
OB_config.mass_min = mass_min;
clear mass_min;


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------- image processing ----------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rgiImage = RGB2RGI2( rgbImage );

%% Background Subtraction

BG_threshold = 12;
ForegroundImage = BackgroundSubtraction( rgiImage,BG_threshold );
rgiImage = ForegroundImage;

RB = imageProcessing( rgiImage,RB_config ); % Returns cell array with 
                                            % information of each brick 
                                            % in the given color
GB = imageProcessing( rgiImage,GB_config );
BB = imageProcessing( rgiImage,BB_config );
YB = imageProcessing( rgiImage,YB_config );
%WB = imageProcessing( rgiImage,WB_config );
OB = imageProcessing( rgiImage,OB_config );

saveImages2

disp('Threshold calibration finished. Press enter to test calibration.');
pause;

%% Convert to robot world coordinate
BrickPixel = GB{1}.Center_of_gravity';
ToolPose = GetSO4FromURpose(CameraPicturePose);
WorldPosBasedOnCamera = PixelToWorldCoordinate(BrickPixel, ToolPose, KK, CameraToObjectDistance);
MeasuredBrickPose = GetSO4FromURpose(GreenBrickPose);
MeasuredBrickPos = MeasuredBrickPose(1:3,4);
MeasuredBrickPos(3) = MeasuredBrickPos(3) - BrickHeight; % subtract brick height as calibration is performed on top of other brick
CameraToRobotOffset = WorldPosBasedOnCamera - MeasuredBrickPos;
BrickPlaceZ = MeasuredBrickPos(3);
save('calib/CameraToRobotOffset.mat', 'CameraToRobotOffset', 'BrickPlaceZ');

%% Go to brick location and pickup
moverobot(robot, 1, [(WorldPosBasedOnCamera-CameraToRobotOffset+[0;0;50])' O]);
moverobot(robot, 1, [(WorldPosBasedOnCamera-CameraToRobotOffset+[0;0;BrickHeight])' O]);
moverobot(robot, 1, [(WorldPosBasedOnCamera-CameraToRobotOffset+[0;0;50])' O]);
%CloseGripper(robot);
moverobot(robot, 1, RobotInitialPose);
moverobot(robot, 1, [500, 120, (BrickPlaceZ+BrickHeight), pi, 0, 0]);
OpenGripper(robot);
moverobot(robot, 1, RobotInitialPose);

%% Try other brick
BrickPixel = RB{1}.Center_of_gravity';
ToolPose = GetSO4FromURpose(CameraPicturePose);
WorldPosBasedOnCamera = PixelToWorldCoordinate(BrickPixel, ToolPose, KK, CameraToObjectDistance);
O2 = [cos(deg2rad(-45-RB{1}.rotation)/2)*pi, sin(deg2rad(-45-RB{1}.rotation)/2)*pi, 0];
moverobot(robot, 1, [(WorldPosBasedOnCamera-CameraToRobotOffset+[0;0;0])' O2]);
CloseGripper(robot);
moverobot(robot, 1, [(WorldPosBasedOnCamera-CameraToRobotOffset+[0;0;50])' O2]);
moverobot(robot, 1, RobotInitialPose);
moverobot(robot, 1, [500, 30, BrickPlaceZ, O]);
OpenGripper(robot);
moverobot(robot, 1, RobotInitialPose);