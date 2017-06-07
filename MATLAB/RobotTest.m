clear all;
Robot_IP = '0.0.0.0';
robot = tcpip(Robot_IP,30000,'NetworkRole','server');
fclose(robot);
disp('Press Play on Robot...')
fopen(robot);
disp('Connected!');

Robot_Pose = readrobotpose(robot)
Translation = Robot_Pose(1:3); % in mm
Orientation = Robot_Pose(4:6);


%%
deg = 0;
orientX = pi*cos(deg2rad(deg/2))
orientY = pi*sin(deg2rad(deg/2))
% Calculate rotation vector
Orientation(1) = orientX;
Orientation(2) = orientY;
Orientation(3) = 0;
moverobot(robot,1,Translation,Orientation);

%%

pos(:,1) = [-400 600 400]';
pos(:,2) = [-400 600 100]';
pos(:,3) = [-400 600 400]';
pos(:,4) = [400 600 400]';
pos(:,5) = [400 600 100]';
pos(:,6) = [400 600 400]';

for (i = 1:size(pos,2))
    moverobot(robot,1,pos(:,i)',Orientation);
end


%%
Translation(1) = 0;
Translation(2) = -400;
Translation(3) = 400;
moverobot(robot,1,Translation,Orientation);