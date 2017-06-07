clear all;
run('Calib_Results.m');

%% See http://www.vision.caltech.edu/bouguetj/calib_doc/htmls/parameters.html

%% Convert from world point to pixel position
% (-15, 15, 50) cm ==> point is to the top left of the image
TestWorldPoint = [0; 31.8; 300+117+177];

xn = [TestWorldPoint(1) / TestWorldPoint(3); TestWorldPoint(2) / TestWorldPoint(3)];

r2 = xn(1)^2 + xn(2)^2;
dx = [2*kc(3)*xn(1)*xn(2) + kc(4)*(r2 + 2*xn(1)^2);
      kc(3)*(r2 + 2*xn(2)^2) + 2*kc(4)*xn(1)*xn(2)];
xd = (1+kc(1)*r2 + kc(2)*r2^2 + kc(5)*r2^3)*xn + dx;

% Calculate pixel position (including distortion)
x_pixel = [fc(1)*(xd(1) + alpha_c*xd(2)) + cc(1);
           fc(2)*xd(2) + cc(2)]

% Calculate pixel position (excluding distortion)       
x_pixel2 = [fc(1)*xn(1) + cc(1);
           fc(2)*xn(2) + cc(2)] 
       
% Which corresponds to the following Matrix operation
KK = [fc(1)   0    cc(1);
      0     fc(2)  cc(2);
      0       0     1];
  
xn_ = [xn;1];  
x_pixel_ = KK*xn_

       
%% Convert from pixel position to world coordinate (seen from camera frame)
PictureHeightFromTable = 0+117+177; % mm
% Calculation is performed without distortion
KK = [fc(1)   0    cc(1);
      0     fc(2)  cc(2);
      0       0     1];
  
Pixel1 = [964; 500];   % pixel position
Pixel2 = [1153; 495];   % pixel position

xp = [Pixel1;1]; % augment to homogeneous pixel position
xn = KK^-1 * xp; % transform into normalized pixel position

% Calculate world position by denormalizing using PictureHeightFromTable
WorldPos1 = xn * PictureHeightFromTable;

xp = [Pixel2;1]; % augment to homogeneous pixel position
xn = KK^-1 * xp; % transform into normalized pixel position

% Calculate world position by denormalizing using PictureHeightFromTable
WorldPos2 = xn * PictureHeightFromTable;
