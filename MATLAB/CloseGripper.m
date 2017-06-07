function CloseGripper(t)
if t.BytesAvailable>0
    fscanf(t,'%c',t.BytesAvailable);
end
fprintf(t,'(5)'); % task = 5 : Close gripper
while t.BytesAvailable==0
end
pause(1);