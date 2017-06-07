% Pixels is the 2D coordinate vector to transform into world 3D coordinate
% ToolPose in SO(4) including translation and rotation
% KK is calibrated camera transformation matrix
% CameraToObjectDistance is Z position of the top of the object which is seen by the camera (distance from camera to item)
function WorldPos = PixelToWorldCoordinate(Pixel, ToolPose, KK, CameraToObjectDistance)            
    % Rotate camera to match robot frame/installation
    % Positive X in camera corresponds to Negative Y in robot
    % Positive Y in camera corresponds to Negative X in robot
    CameraRotation = trotz(deg2rad(90));
    
    CameraPose = ToolPose * CameraRotation;  
    
    xp = [Pixel;1]; % augment to homogeneous pixel position
    xn = KK^-1 * xp; % transform into normalized pixel position
    
    % Calculate real-world position seen from camera perspective
    WorldPosCamera = xn * CameraToObjectDistance;
    
    % Convert camera position into world position using the Camera Pose
    WorldPosCamera_ = [WorldPosCamera;1];
    WorldPos_ = CameraPose * WorldPosCamera_;
    
    WorldPos = WorldPos_(1:3);