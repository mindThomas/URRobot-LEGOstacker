function OpenGripper(t)
if t.BytesAvailable>0
    fscanf(t,'%c',t.BytesAvailable);
end
fprintf(t,'(6)'); % task = 6 : Open gripper
while t.BytesAvailable==0
end
pause(1);