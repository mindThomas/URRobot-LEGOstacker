clear all;
clc;

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

%%
RobotInitialPose = readrobotpose(robot)
T = RobotInitialPose(1:3); % in mm
O = RobotInitialPose(4:6);

OpenGripper(robot);

%%
CalibrationPositions = zeros(11, 6);

CalibrationPositions(1,:) = [485 -200 450 pi 0 0];
CalibrationPositions(2,:) = [500 -200 400 pi 0 0];
CalibrationPositions(3,:) = [400 -100 400 pi-0.3 0.5 0.25];
CalibrationPositions(4,:) = [400 -270 400 pi+0.3 0.5 0.25];
CalibrationPositions(5,:) = [500 -400 300 pi+0.3 -0.4 0.0];
CalibrationPositions(6,:) = [520 -330 350 pi -0.45 0.0];
CalibrationPositions(7,:) = [510 -380 300 pi+0.2 0.0 0.2];
CalibrationPositions(8,:) = [400 -380 300 pi+0.4 0.4 0.5];
CalibrationPositions(9,:) = [520 0 300 pi-0.5 0 0.0];
CalibrationPositions(10,:) = [380 0 300 pi-0.5 0.3 0.4];
CalibrationPositions(11,:) = [380 100 280 pi-0.5 0.3 0.4];
CalibrationPositions(12,:) = [650 -80 280 pi-0.5 0.3 -0.5];

%%
for (i = 1:size(CalibrationPositions,1))
    moverobot(robot, 1, CalibrationPositions(i,:));
    pause(2);
    img = snapshot(cam);    
    imwrite(img, ['calib/' num2str(i) '.bmp'], 'bmp')
    imshow(img);
end

%%
moverobot(robot, 1, [T O]);
save('calib/CalibrationPositions.mat', 'CalibrationPositions');

%% Execute calibration
cd('calib');
data_calib;
click_calib;
go_calib_optim;
saving_calib;
ext_calib;
cd('..');