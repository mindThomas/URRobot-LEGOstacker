function KK = GetCameraCalibrationMatrix(CalibrationFilename)
    CamCal = load(CalibrationFilename);
    % Calculation is performed without distortion
    KK = [CamCal.fc(1)   0    CamCal.cc(1);
          0     CamCal.fc(2)  CamCal.cc(2);
          0       0     1];