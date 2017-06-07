function Orientation = GetOrientationVector(deg)
    orientX = pi*cos(deg/2);
    orientY = pi*sin(deg/2);
    % Calculate rotation vector
    Orientation = zeros(3,1);
    Orientation(1) = orientX;
    Orientation(2) = orientY;
    Orientation(3) = 0;