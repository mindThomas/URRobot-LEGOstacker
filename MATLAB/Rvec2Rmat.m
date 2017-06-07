% Get SO(3) rotation matrix from rotation vector from UR-Robot
% Does the same thing as the rodrigues() function from the Camera omc_1 calibration toolbox
function Rmat = Rvec2Rmat(Rvec)
    theta = norm(Rvec);
    K = Rvec / norm(Rvec);

    % Angle-axis conversion
    ct = cos(theta);
    st = sin(theta);
    kx = K(1); ky = K(2); kz = K(3);
    Rmat = [kx*kx*(1-ct) + ct,  kx*ky*(1-ct) - kz*st,  kx*kz*(1-ct) + ky*st;
         kx*ky*(1-ct) + kz*st,  ky*ky*(1-ct) + ct,  ky*kz*(1-ct) - kx*st;
         kx*kz*(1-ct) - ky*st,  ky*kz*(1-ct) + kx*st,  kz*kz*(1-ct) + ct];