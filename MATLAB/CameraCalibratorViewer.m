load('calib/CalibrationPositions.mat');

Base = eye(4);
Offset = [0; 0; 177+117];

%Camera = transl(200, 100, 300) * trotz(Yaw) * troty(Pitch) * trotx(Roll);

figure(22);
trplot(Base, 'width', 20, 'length', 100);
xlim([-100 700]);
ylim([-600 200]);
zlim([0 700]);

%% Convert robot calibration positions to SO(4) homogeneous transformation matrices
CalibrationPositionMatrices = zeros(4,4, size(CalibrationPositions,1));

for (i = 1:size(CalibrationPositions,1))
    T = CalibrationPositions(i,1:3)' + Offset;
    R = Rvec2Rmat(CalibrationPositions(i,4:6)');
    SO4 = [[R; zeros(1,3)], [T; 1]];
    CalibrationPositionMatrices(:,:, i) = SO4;
end

%% Plot camera positions
hold on;
for (i = 1:size(CalibrationPositionMatrices,3))
    trplot(CalibrationPositionMatrices(:,:,i), 'width', 10, 'length', 100, 'frame', num2str(i));
end
hold off;

%%
hold on;
T = CalibrationPositions(1,1:3)' + Offset;
err = CalibrationPositions(1,1:3)' + Offset - Tc_1
R = Rvec2Rmat(omc_1);
SO4 = [[R; zeros(1,3)], [T; 1]];
trplot(SO4, 'width', 10, 'length', 100, 'color', 'r', 'frame', 'X');

T = CalibrationPositions(2,1:3)' + Offset;
err = CalibrationPositions(2,1:3)' + Offset - Tc_2
R = Rvec2Rmat2(omc_2);
SO4 = [[R; zeros(1,3)], [T; 1]];
trplot(SO4, 'width', 10, 'length', 100, 'color', 'r', 'frame', 'X');

T = CalibrationPositions(3,1:3)' + Offset;
err = CalibrationPositions(3,1:3)' + Offset - Tc_3
R = Rvec2Rmat2(omc_3);
SO4 = [[R; zeros(1,3)], [T; 1]];
trplot(SO4, 'width', 10, 'length', 100, 'color', 'r', 'frame', 'X');

T = CalibrationPositions(4,1:3)' + Offset;
err = CalibrationPositions(4,1:3)' + Offset - Tc_4
R = Rvec2Rmat2(omc_4);
SO4 = [[R; zeros(1,3)], [T; 1]];
trplot(SO4, 'width', 10, 'length', 100, 'color', 'r', 'frame', 'X');

T = CalibrationPositions(5,1:3)' + Offset;
err = CalibrationPositions(5,1:3)' + Offset - Tc_4
R = Rvec2Rmat2(omc_5);
SO4 = [[R; zeros(1,3)], [T; 1]];
trplot(SO4, 'width', 10, 'length', 100, 'color', 'r', 'frame', 'X');

T = CalibrationPositions(6,1:3)' + Offset;
err = CalibrationPositions(6,1:3)' + Offset - Tc_4
R = Rvec2Rmat2(omc_6);
SO4 = [[R; zeros(1,3)], [T; 1]];
trplot(SO4, 'width', 10, 'length', 100, 'color', 'r', 'frame', 'X');

T = CalibrationPositions(7,1:3)' + Offset;
err = CalibrationPositions(7,1:3)' + Offset - Tc_4
R = Rvec2Rmat2(omc_7);
SO4 = [[R; zeros(1,3)], [T; 1]];
trplot(SO4, 'width', 10, 'length', 100, 'color', 'r', 'frame', 'X');

T = CalibrationPositions(8,1:3)' + Offset;
err = CalibrationPositions(8,1:3)' + Offset - Tc_4
R = Rvec2Rmat2(omc_8);
SO4 = [[R; zeros(1,3)], [T; 1]];
trplot(SO4, 'width', 10, 'length', 100, 'color', 'r', 'frame', 'X');

T = CalibrationPositions(9,1:3)' + Offset;
err = CalibrationPositions(9,1:3)' + Offset - Tc_4
R = Rvec2Rmat2(omc_9);
SO4 = [[R; zeros(1,3)], [T; 1]];
trplot(SO4, 'width', 10, 'length', 100, 'color', 'r', 'frame', 'X');

T = CalibrationPositions(10,1:3)' + Offset;
err = CalibrationPositions(10,1:3)' + Offset - Tc_4
R = Rvec2Rmat2(omc_10);
SO4 = [[R; zeros(1,3)], [T; 1]];
trplot(SO4, 'width', 10, 'length', 100, 'color', 'r', 'frame', 'X');

T = CalibrationPositions(11,1:3)' + Offset;
err = CalibrationPositions(11,1:3)' + Offset - Tc_4
R = Rvec2Rmat2(omc_11);
SO4 = [[R; zeros(1,3)], [T; 1]] * trotz(deg2rad(90));
trplot(SO4, 'width', 10, 'length', 100, 'color', 'r', 'frame', 'X');


hold off;