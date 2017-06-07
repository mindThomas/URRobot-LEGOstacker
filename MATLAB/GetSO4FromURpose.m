% UR pose is a row vector with 6 elements
% - First 3 elements is the translation
% - Last 3 elements is the rotation vector
function SO4 = GetSO4FromURpose(URpose)
    T = URpose(1:3)';
    R = Rvec2Rmat(URpose(4:6)');
    SO4 = [[R; zeros(1,3)], [T; 1]];    