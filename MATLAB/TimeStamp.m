function [s]=TimeStamp
%[s]=TimeStamp
% time stamp in the format
% year-month-day-hours-h-minutes-m-second-s

% Get current time as date vector
t=clock;

% convert date vector into the string: year-month-day
yyyy_mm_dd=datestr(t, 29);

% convert date vector into the string: day-month-year[blank]hours:minutes:seconds
s=datestr(t, 0);

% get index of the blank
index=find(s==' ');

% remove the string that is before the blank
s=s((index+1):end);

% get the indices of the colons ":"
ii=find(s==':');

%change the first colon into "h" and the second one into "m". Add an "s" at the end of the
%string
h_m_s=strcat(  s(1:(ii(1)-1)), 'h', s( (ii(1)+1): (ii(2)-1)), 'm', s( (ii(2)+1):end), 's');

% concate the two strings
s=strcat(yyyy_mm_dd, '-', h_m_s);
end