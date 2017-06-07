function rotation = find_rotation(j,BLOB_output_img,Center_of_gravity)
Center_of_gravity_x = Center_of_gravity(1);
Center_of_gravity_y = Center_of_gravity(2);

[Y,X] = find(BLOB_output_img==j);

% first we find the vectors going from the Center_of_gravity to each 
% corner of the bricks
x_min = min(X);
x_max = max(X);
y_min = min(Y);
y_max = max(Y);

Xmin_Index = find(X == x_min);
Xmax_Index = find(X == x_max);
Ymin_Index = find(Y == y_min);
Ymax_Index = find(Y == y_max);

if  false
% if  (~isempty(find(Y(Xmin_Index)<Center_of_gravity_y))      &&...  
%     ~isempty(find(Y(Xmin_Index)>Center_of_gravity_y)))      ||... 
%     (~isempty(find(Y(Xmax_Index)<Center_of_gravity_y))      &&...  
%     ~isempty(find(Y(Xmax_Index)>Center_of_gravity_y)))      ||...
%     (~isempty(find(X(Ymin_Index)<Center_of_gravity_x))      &&...  
%     ~isempty(find(X(Ymin_Index)>Center_of_gravity_x)))      ||... 
%     (~isempty(find(X(Ymax_Index)<Center_of_gravity_x))      &&...  
%     ~isempty(find(X(Ymax_Index)>Center_of_gravity_x)))
%     disp('What is the odds?!?! The brick must be turned 0 degrees!')
%     disp('Or at least close enough ;)')
    
    rotation = 0;
    
else
    vector1 = [X(Xmin_Index(1))-Center_of_gravity_x;...
               Y(Xmin_Index(1))-Center_of_gravity_y];

    vector2 = [X(Xmax_Index(end))-Center_of_gravity_x;...
               Y(Xmax_Index(end))-Center_of_gravity_y];

    vector3 = [X(Ymin_Index(1))-Center_of_gravity_x;...
               Y(Ymin_Index(1))-Center_of_gravity_y];

    vector4 = [X(Ymax_Index(end))-Center_of_gravity_x;...
               Y(Ymax_Index(end))-Center_of_gravity_y];     

    % atand(y/x)
    v1 = atand(vector1(2)/vector1(1))
    v2 = atand(vector2(2)/vector2(1))

    % atand(x/y)
    v3 = atand(vector3(1)/vector3(2))
    v4 = atand(vector4(1)/vector4(2))     

    % we define zero degrees to be where the sides of the cubes are alligned
    % with the axes, but we find the degrees from the edges, and therefore
    % (there is 45 degrees difference between an edge and):
    v1 = 45 - v1
    v2 = 45 - v2
    v3 = 45 + v3
    v4 = 45 + v4
    
    
    
    rotation = mean([v1,v2,v3,v4]);
end
end

