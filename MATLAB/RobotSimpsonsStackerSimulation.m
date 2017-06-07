clear all;
clc;

%% Constants/definitions
BrickWidth = 30; % mm
BrickHeight = 20;
TransportHeight = 100;

PickupHeight = 30;
PlacementHeight = 30;
BuildPlateOrigo = [-400 200 0]'; % center of where first brick can be placed on build plate

XSpacing = 2*BrickWidth; % mm spacing between placements of simpsons figures
YSpacing = 0; % mm

SimpsonsToBuild = { 'bwy'; 'boy'; 'by'; 'yry'; 'gyb' };


%% Initialize robot
RobotEnabled = true;
if (RobotEnabled)
    Robot_IP = '0.0.0.0';
    robot = tcpip(Robot_IP,30000,'NetworkRole','server');
    fclose(robot);
    disp('Press Play on Robot...')
    fopen(robot);
    disp('Connected!');

    RobotInitialPose = readrobotpose(robot)
    Translation = RobotInitialPose(1:3); % in mm
    Orientation = RobotInitialPose(4:6);
    
    % Initialize robot position
    disp('Initializing robot');
    T = BuildPlateOrigo + [0 0 TransportHeight]';
    O = GetOrientationVector(0);
    moverobot(robot,1,T,O);
    disp('Opening gripper');
    OpenGripper(robot);
end

disp(' ');
disp('-------------------------------------------------');
   
%% Get list of bricks
% Generate random list of yellow bricks
for (i = 1:10)
    RB{i}.Position = [200;200] + randi(400,2,1);
    RB{i}.Rotation = pi*2*(rand()-0.5);
end

% Generate random list of blue bricks
for (i = 1:10)
    BB{i}.Position = [200;200] + randi(400,2,1);
    BB{i}.Rotation = pi*2*(rand()-0.5);    
end

% Generate random list of orange bricks
for (i = 1:6)
    OB{i}.Position = [200;200] + randi(400,2,1);
    OB{i}.Rotation = pi*2*(rand()-0.5);    
end

% Generate random list of red bricks
for (i = 1:6)
    YB{i}.Position = [200;200] + randi(400,2,1);
    YB{i}.Rotation = pi*2*(rand()-0.5);    
end

% Generate random list of white bricks
for (i = 1:6)
    WB{i}.Position = [200;200] + randi(400,2,1);
    WB{i}.Rotation = pi*2*(rand()-0.5);    
end

% Generate random list of green bricks
for (i = 1:6)
    GB{i}.Position = [200;200] + randi(400,2,1);
    GB{i}.Rotation = pi*2*(rand()-0.5);    
end


%% Generate robot trajectory on the fly
BuildPlatePositionIndex = 0; % starting in the lower left corner
BuildPlateHeightIndex = 0;

for (SimpsonIndex = 1:length(SimpsonsToBuild))
    disp(' ');
    t = sprintf('#### Building Simpson figure %d of %d ####', SimpsonIndex, length(SimpsonsToBuild)); disp(t);
    Simpson = SimpsonsToBuild{SimpsonIndex};
    for (BrickIndex = 1:length(Simpson))
        Brick = Simpson(BrickIndex);                
        if (Brick == 'r')
            BrickPos = RB{end}.Position;
            BrickRotation = RB{end}.Rotation;
            RB(end) = [];            
        elseif (Brick == 'g')
            BrickPos = GB{end}.Position;
            BrickRotation = GB{end}.Rotation;
            GB(end) = [];    
        elseif (Brick == 'b')
            BrickPos = BB{end}.Position;
            BrickRotation = BB{end}.Rotation;
            BB(end) = [];              
        elseif (Brick == 'y')
            BrickPos = YB{end}.Position;
            BrickRotation = YB{end}.Rotation;
            YB(end) = [];              
        elseif (Brick == 'w')
            BrickPos = WB{end}.Position;
            BrickRotation = WB{end}.Rotation;
            WB(end) = []; 
        elseif (Brick == 'o')
            BrickPos = OB{end}.Position;
            BrickRotation = OB{end}.Rotation;
            OB(end) = [];              
        else                    
            error('Incorrect brick selected');
        end
        
        t = sprintf('   Moving towards brick %d of %d of color "%c"', BrickIndex, length(Simpson), Brick(1)); disp(t);
        
        % Move over brick
        T = [BrickPos; TransportHeight];
        O = GetOrientationVector(BrickRotation);
        moverobot(robot,1,T,O);
        
        % Move down above brick
        disp('      Picking up brick');
        T = [BrickPos; PickupHeight];        
        moverobot(robot,1,T,O);        
        
        disp('      Closing gripper');
        CloseGripper(robot);
        
        % Move to transport height
        T = [BrickPos; TransportHeight];        
        moverobot(robot,1,T,O);     
        
        % Calculate placement location
        PlacementXY = BuildPlateOrigo(1:2) + (SimpsonIndex-1)*[XSpacing;YSpacing];
        PlacementZ = PlacementHeight + (BrickIndex-1)*BrickHeight;
        
        % Move above placement location
        disp('      Moving to build plate location');
        T = [PlacementXY; TransportHeight];
        O = GetOrientationVector(0); % orient correct to place
        moverobot(robot,1,T,O);      
        
        % Place brick
        disp('      Placing brick');
        T = [PlacementXY; PlacementZ];
        O = GetOrientationVector(0); % orient correct to place
        moverobot(robot,1,T,O); 
        
        disp('      Opening gripper');
        OpenGripper(robot);
        
        % Move above placement location again
        T = [PlacementXY; TransportHeight];
        O = GetOrientationVector(0); % orient correct to place
        moverobot(robot,1,T,O);          
    end
end

disp('-------------------------------------------------');
disp(' ');
disp('Finished building Simpson figures!');