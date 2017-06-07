% UR pose is a row vector with 6 elements
% - First 3 elements is the translation
% - Last 3 elements is the rotation vector
function URpose = GetURposeFromSO4(SO4)
    T = SO4(1:3,4)';
    O = Rmat2Rvec(SO4(1:3,1:3))';      
    URpose = [T O];