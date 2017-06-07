% Get UR-Robot compatible rotation vector from SO(3) rotation matrix
function Rvec = Rmat2Rvec(Rmat)
    R = Rmat;
    
    % Angle-axis conversion
    theta = acos((R(1,1)+R(2,2)+R(3,3) - 1)/2);
    K = 1/(2*sin(theta)) * [R(3,2)-R(2,3); R(1,3)-R(3,1); R(2,1)-R(1,2)];

    Rvec = theta * (K / norm(K));