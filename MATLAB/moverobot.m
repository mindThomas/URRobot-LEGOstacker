% Goal_Pose should be in mm and Orientation the rotation vector
function P_new = moverobot(t,wait,Goal_Pose,Orientation)
if nargin < 3
    error('error; not enough input arguments')
elseif nargin == 3
    P = Goal_Pose;
elseif nargin == 4
    P = [Goal_Pose,Orientation];
end
if t.BytesAvailable>0
    fscanf(t,'%c',t.BytesAvailable);
end

P(1:3) = P(1:3) * 0.001; % Converting to meter
P_char = ['(',num2str(P(1)),',',...
    num2str(P(2)),',',...
    num2str(P(3)),',',...
    num2str(P(4)),',',...
    num2str(P(5)),',',...
    num2str(P(6)),...
    ')'];
success = 'X';
while strcmp(success,'X')
    fprintf(t,'(1)'); % task = 1 : moving task
    pause(0.01);% Tune this to meet your system
    fprintf(t,P_char);
    while t.BytesAvailable==0
        %t.BytesAvailable
    end
    success  = readrobotMsg(t);
end
if (~strcmp(success,'1') && ~strcmp(success,'1X') && ~strcmp(success,'X1'))
    disp(success);
    error('error sending robot pose')
%else
    %disp('successfully send command to robot queue');
end

success = '1';
if wait == true    
    while (~strcmp(success,'X') && ~strcmp(success,'1X') && ~strcmp(success,'X1'))
        while t.BytesAvailable==0
            %t.BytesAvailable
        end
        success  = readrobotMsg(t);
    end
    if (~strcmp(success,'X') && ~strcmp(success,'1X') && ~strcmp(success,'X1'))
        error('Error occured while moving');    
    %else
        %disp('Finished moving')
    end
end
%pause(0.5)
%P_new = readrobotpose(t);