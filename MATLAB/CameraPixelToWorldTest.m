clear all;
clc;

KK = GetCameraCalibrationMatrix('calib/Calib_Results.mat');
KKinv = KK^-1;

cc = [1151; 767]; % Camera pixel center (from calibration file)

% Camera translation/displacement from tool center:
% # -117 mm in z-axis (tool pointing direction axis)
% # 48 mm in x-axis (vertical/up-down in camera view)
CameraDisplacement = [48 0 -117]';

% Compared to robot base plate, the pickup plate was located at a different z-location
PlateZ = -177; % Plate Z location compared to robot base plate was Z=-177

ToolURpose = [490 -200 300  pi 0 0]; % where distant picture is taken
ToolPose = GetSO4FromURpose(ToolURpose);
Pixel1 = [879; 763];
Pixel2 = [975; 761];

Pixel1 = [9; 1369];
Pixel2 = [2297; 1369];

World1 = PixelToWorldCoordinate(Pixel1, ToolPose, KK, CameraDisplacement, PlateZ)
World2 = PixelToWorldCoordinate(Pixel2, ToolPose, KK, CameraDisplacement, PlateZ)

World1SO4 = transl(World1);
World2SO4 = transl(World2);


figure(1);
Base = eye(4);
trplot(Base, 'width', 20, 'length', 100);
xlim([-100 700]);
ylim([-600 200]);
zlim([-200 600]);

hold on;
trplot(ToolPose, 'width', 20, 'length', 100);
trplot(World1SO4, 'width', 20, 'length', 100);
trplot(World2SO4, 'width', 20, 'length', 100);
hold off;

% cam = webcam(2);
% %cam.Resolution = '320x240';
% %cam.Resolution = '800x600';
% cam.Resolution = '2304x1536';
% cam.ExposureMode = 'manual';
% cam.Exposure = -4;
% 
% figure(1);
% imshow(cam.snapshot);
% 
% %%
% Robot_IP = '0.0.0.0';
% robot = tcpip(Robot_IP,30000,'NetworkRole','server');
% fclose(robot);
% disp('Press Play on Robot...')
% fopen(robot);
% disp('Connected!');
% 
% %%
% RobotInitialPose = readrobotpose(robot)
% T = RobotInitialPose(1:3); % in mm
% O = RobotInitialPose(4:6);
% 
% OpenGripper(robot);