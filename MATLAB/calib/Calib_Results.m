% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1463.984407963500400 ; 1465.398271839136000 ];

%-- Principal point:
cc = [ 954.752995071323540 ; 520.826048487661860 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.053464245988618 ; -0.085695317059133 ; -0.003229820392413 ; -0.003404722138491 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 10.231560503071281 ; 9.817998667047611 ];

%-- Principal point uncertainty:
cc_error = [ 8.881219594033661 ; 7.330705832961168 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.010864954707882 ; 0.025401925688692 ; 0.001901535590658 ; 0.002409172717150 ; 0.000000000000000 ];

%-- Image size:
nx = 1920;
ny = 1080;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 12;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ -5.900136e-03 ; 3.002831e-02 ; 1.567106e+00 ];
Tc_1  = [ 9.714728e+01 ; -9.703100e+01 ; 5.259095e+02 ];
omc_error_1 = [ 1.045018e-02 ; 1.073079e-02 ; 8.831725e-04 ];
Tc_error_1  = [ 3.214957e+00 ; 2.639983e+00 ; 3.765173e+00 ];

%-- Image #2:
omc_2 = [ -5.502692e-03 ; 2.891544e-02 ; 1.567154e+00 ];
Tc_2  = [ 9.631180e+01 ; -8.246508e+01 ; 4.745478e+02 ];
omc_error_2 = [ 9.279823e-03 ; 9.462631e-03 ; 7.605118e-04 ];
Tc_error_2  = [ 2.899998e+00 ; 2.385353e+00 ; 3.403298e+00 ];

%-- Image #3:
omc_3 = [ -3.384757e-01 ; -3.292149e-02 ; 1.903350e+00 ];
Tc_3  = [ 1.559641e+02 ; -5.104586e+01 ; 5.460651e+02 ];
omc_error_3 = [ 8.518014e-03 ; 7.859908e-03 ; 1.657437e-03 ];
Tc_error_3  = [ 3.336917e+00 ; 2.761812e+00 ; 3.849787e+00 ];

%-- Image #4:
omc_4 = [ 1.557592e-01 ; 4.175541e-01 ; 1.828973e+00 ];
Tc_4  = [ 2.110173e+02 ; -9.879011e+01 ; 4.640955e+02 ];
omc_error_4 = [ 7.880025e-03 ; 8.440935e-03 ; 1.252048e-03 ];
Tc_error_4  = [ 2.943942e+00 ; 2.412878e+00 ; 3.542905e+00 ];

%-- Image #5:
omc_5 = [ 2.508721e-01 ; 2.785335e-01 ; 1.317876e+00 ];
Tc_5  = [ -4.330033e+01 ; -6.566418e+01 ; 4.006442e+02 ];
omc_error_5 = [ 6.919943e-03 ; 7.018681e-03 ; 1.795937e-03 ];
Tc_error_5  = [ 2.454202e+00 ; 2.002581e+00 ; 2.786740e+00 ];

%-- Image #6:
omc_6 = [ 3.394448e-02 ; 6.291027e-02 ; 1.280301e+00 ];
Tc_6  = [ -5.579214e+01 ; -4.850536e+01 ; 4.260353e+02 ];
omc_error_6 = [ 8.660859e-03 ; 8.774207e-03 ; 1.400210e-03 ];
Tc_error_6  = [ 2.607434e+00 ; 2.134937e+00 ; 2.930607e+00 ];

%-- Image #7:
omc_7 = [ 8.117409e-02 ; 2.884117e-01 ; 1.556091e+00 ];
Tc_7  = [ -2.759425e+01 ; -4.076877e+01 ; 3.984792e+02 ];
omc_error_7 = [ 8.235525e-03 ; 7.144176e-03 ; 1.726187e-03 ];
Tc_error_7  = [ 2.438404e+00 ; 1.978804e+00 ; 2.696890e+00 ];

%-- Image #8:
omc_8 = [ 1.479642e-01 ; 6.193267e-01 ; 1.740842e+00 ];
Tc_8  = [ 9.916748e+01 ; -1.004100e+02 ; 4.282964e+02 ];
omc_error_8 = [ 6.628539e-03 ; 6.393710e-03 ; 1.926290e-03 ];
Tc_error_8  = [ 2.650150e+00 ; 2.150107e+00 ; 3.169769e+00 ];

%-- Image #9:
omc_9 = [ -3.855826e-01 ; -3.700023e-01 ; 1.535978e+00 ];
Tc_9  = [ 1.332539e+02 ; -6.145938e+01 ; 4.777709e+02 ];
omc_error_9 = [ 7.052763e-03 ; 6.779726e-03 ; 1.777446e-03 ];
Tc_error_9  = [ 2.927505e+00 ; 2.419046e+00 ; 3.168682e+00 ];

%-- Image #10:
omc_10 = [ -6.025394e-01 ; -1.082538e-01 ; 1.749141e+00 ];
Tc_10  = [ 1.741050e+02 ; -4.354830e+01 ; 5.330480e+02 ];
omc_error_10 = [ 7.438986e-03 ; 6.710981e-03 ; 2.313122e-03 ];
Tc_error_10  = [ 3.289107e+00 ; 2.722921e+00 ; 3.557295e+00 ];

%-- Image #11:
omc_11 = [ -6.070554e-01 ; -1.150812e-01 ; 1.747509e+00 ];
Tc_11  = [ 2.716862e+02 ; -1.992383e+01 ; 5.558881e+02 ];
omc_error_11 = [ 7.715678e-03 ; 7.178311e-03 ; 2.540597e-03 ];
Tc_error_11  = [ 3.542306e+00 ; 2.952441e+00 ; 3.889681e+00 ];

%-- Image #12:
omc_12 = [ -4.724511e-02 ; -6.281334e-01 ; 1.740250e+00 ];
Tc_12  = [ 9.372079e+01 ; -3.590004e+00 ; 4.104947e+02 ];
omc_error_12 = [ 6.894945e-03 ; 6.805913e-03 ; 1.755639e-03 ];
Tc_error_12  = [ 2.497301e+00 ; 2.053125e+00 ; 2.783515e+00 ];

