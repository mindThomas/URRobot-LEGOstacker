clear all;
close all;
clc;

load('calib/CameraToRobotOffset.mat');
KK = GetCameraCalibrationMatrix('calib/Calib_Results.mat');
Cal = load('calib/Calib_Results.mat', 'Tc_1');
CameraToObjectDistance = Cal.Tc_1(3);
clear Cal;

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
RobotInitialPose = readrobotpose(robot);
T = RobotInitialPose(1:3); % in mm
O = RobotInitialPose(4:6);
OpenGripper(robot);

%% Move robot to camera picture location
CameraPicturePose = [485, -200, 450, pi, 0, 0];
moverobot(robot, 1, CameraPicturePose);
disp('Prepare bricks on table. Press enter when ready and clear.');
pause();
rgbImage = snapshot(cam);
imshow(rgbImage);

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
load('thresholds.mat');

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
imwrite(rgbImage, [TimeStamp '.bmp']);

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

PlaceX = 400;
PlaceY = 120;
PlaceZ = BrickPlaceZ;
RobotPlaceLocation = [PlaceX, PlaceY, PlaceZ, pi, 0, 0];
BricksPickedUp = 1;
Bricks = {RB, GB, BB, YB, OB};

%% Convert to robot world coordinate
while (BricksPickedUp > 0)
    BricksPickedUp = 0;
    PickupZoffset = 0;   
    for (i = 1:length(Bricks))        
        if (length(Bricks{i}) > 0)
            Brick = Bricks{i}{1};
            BricksPickedUp = BricksPickedUp + 1;

            BrickPixel = Brick.boudingBoxCenter';
            ToolPose = GetSO4FromURpose(CameraPicturePose);
            BrickPos = PixelToWorldCoordinate(BrickPixel, ToolPose, KK, CameraToObjectDistance);
            BrickPos = BrickPos - CameraToRobotOffset; % subtract calibrated offset (this assumes camera frame is aligned with robot frame rotation wise)
            BrickPos(3) = BrickPos(3) + PickupZoffset; % moves upwards to allow stacking
            if (BricksPickedUp > 1)
                BrickPos(3) = BrickPos(3) - 1; % move a bit more down to stack properly
            end
            
            % Go to brick location and pickup
            BrickPose = ToolPose * trotz(deg2rad(-Brick.rotation + 45)); % added 45 degrees to due gripper rotation
            %BrickPose(1:3,4) = BrickPos - CameraToRobotOffset; % bruteforce translation but keep rotation and correct with calibrated offset
            BrickPose(1:3,4) = BrickPos; % bruteforce translation but keep rotation
            BrickPoseUR = GetURposeFromSO4(BrickPose);

            % Move to brick and pickup
            BrickPoseUR(3) = BrickPoseUR(3) + 50; % move to brick above it
            moverobot(robot, 1, BrickPoseUR);
            BrickPoseUR(3) = BrickPoseUR(3) - 50; % move down and stack
            moverobot(robot, 1, BrickPoseUR);
            CloseGripper(robot);

            % Move away with picked up brick
            BrickPoseUR(3) = BrickPoseUR(3) + 50; % move down and stack
            moverobot(robot, 1, BrickPoseUR);        

            % Set new pickup height
            PickupZoffset = PickupZoffset + BrickHeight;
           
            % Remove used brick
            Bricks{i}(1) = [];
        end
    end

    if (BricksPickedUp > 0)
        % Move a bit to the right of place location (to avoid tipping existing placed blocks)
        RobotPlaceLocation = [PlaceX, (PlaceY-150), (PlaceZ + PickupZoffset + 50), pi, 0, 0];    
        moverobot(robot, 1, RobotPlaceLocation);
        % Move to place location
        RobotPlaceLocation = [PlaceX, PlaceY, (PlaceZ + PickupZoffset + 50), pi, 0, 0];    
        moverobot(robot, 1, RobotPlaceLocation);
        % Move down    
        RobotPlaceLocation = [PlaceX, PlaceY, (PlaceZ + PickupZoffset - BrickHeight + 1), pi, 0, 0];
        moverobot(robot, 1, RobotPlaceLocation);
        % And release (open gripper)        
        OpenGripper(robot);        
        % Move up
        RobotPlaceLocation = [PlaceX, PlaceY, (PlaceZ + PickupZoffset + 50), pi, 0, 0];    
        moverobot(robot, 1, RobotPlaceLocation);
        % Move away
        RobotPlaceLocation = [PlaceX, (PlaceY-150), (PlaceZ + PickupZoffset + 50), pi, 0, 0];    
        moverobot(robot, 1, RobotPlaceLocation);

        PlaceX = PlaceX + 60;
    end
end