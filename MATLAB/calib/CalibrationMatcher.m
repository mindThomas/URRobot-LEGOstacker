% http://www.vision.caltech.edu/bouguetj/calib_doc/htmls/parameters.html
load('Calib_Results.mat');

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

for (i = 1:size(CalibrationPositions,1))
    RobotPose(:,:,i) = GetSO4FromURpose(CalibrationPositions(1,:))*trotz(deg2rad(90));
    sR = sprintf('omc_%d', i);
    sT = sprintf('Tc_%d', i);
    rotVector = eval(sR);
    R(:,:,i) = Rvec2Rmat(rotVector);
    T(:,i) = eval(sT);
    SO4(:,:,i) = [R(:,:,i) T(:,i); 0 0 0 1];
end

figure(1);
trplot(eye(4), 'length', 100);
hold on;
trplot(RobotPose(:,:,1), 'length', 100);
for (i = 1:10)
    trplot(RobotPose(:,:,i)*SO4(:,:,i), 'length', 100);
end
hold off;
xlim([-100 800]);
ylim([-600 200]);
zlim([-300 500]);