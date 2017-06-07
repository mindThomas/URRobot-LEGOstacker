function rotation = find_rotation2(j,BLOB_output_img,Center_of_gravity)
Center_of_gravity_x = Center_of_gravity(1);
Center_of_gravity_y = Center_of_gravity(2);


BLOB_output_img_norm = BLOB_output_img==j; % matrix with ones in blob position

a_x = linspace(1-Center_of_gravity_x,size(BLOB_output_img,2)-Center_of_gravity_x,size(BLOB_output_img,2));
x = ones(size(BLOB_output_img,1),1)*a_x;
BLOB_output_img_X = BLOB_output_img_norm.*x;
BLOB_output_img_X_squared = BLOB_output_img_X.^2;

a_y = linspace(1-Center_of_gravity_y,size(BLOB_output_img,1)-Center_of_gravity_y,size(BLOB_output_img,1));
y = (ones(size(BLOB_output_img,2),1)*a_y)';
BLOB_output_img_Y = BLOB_output_img_norm.*y;
BLOB_output_img_Y_squared = BLOB_output_img_Y.^2;

BLOB_output_img_dist_squared = BLOB_output_img_X_squared + BLOB_output_img_Y_squared;

max_dist_1q = max(max(BLOB_output_img_dist_squared(1:Center_of_gravity_y,Center_of_gravity_x:end))); % first quadrant
max_dist_2q = max(max(BLOB_output_img_dist_squared(1:Center_of_gravity_y,1:Center_of_gravity_x))); % second quadrant
max_dist_3q = max(max(BLOB_output_img_dist_squared(Center_of_gravity_y:end,1:Center_of_gravity_x))); % third quadrant
max_dist_4q = max(max(BLOB_output_img_dist_squared(Center_of_gravity_y:end,Center_of_gravity_x:end))); % fourth quadrant

[y_vq1,x_vq1] = find(BLOB_output_img_dist_squared(1:Center_of_gravity_y,Center_of_gravity_x:end)==max_dist_1q);
[y_vq2,x_vq2] = find(BLOB_output_img_dist_squared(1:Center_of_gravity_y,1:Center_of_gravity_x)==max_dist_2q);
[y_vq3,x_vq3] = find(BLOB_output_img_dist_squared(Center_of_gravity_y:end,1:Center_of_gravity_x)==max_dist_3q);
[y_vq4,x_vq4] = find(BLOB_output_img_dist_squared(Center_of_gravity_y:end,Center_of_gravity_x:end)==max_dist_4q);


%% take into account that the indexing is in the local quadrant coordinates
y_vq1 = y_vq1 + 0;
x_vq1 = x_vq1 + Center_of_gravity_x;

y_vq2 = y_vq2 + 0;
x_vq2 = x_vq2 + 0;

y_vq3 = y_vq3 + Center_of_gravity_y;
x_vq3 = x_vq3 + 0;

y_vq4 = y_vq4 + Center_of_gravity_y;
x_vq4 = x_vq4 + Center_of_gravity_x;

vq1 = [x_vq1-Center_of_gravity_x;...
       y_vq1-Center_of_gravity_y];

vq2 = [x_vq2-Center_of_gravity_x;...
       y_vq2-Center_of_gravity_y];

vq3 = [x_vq3-Center_of_gravity_x;...
       y_vq3-Center_of_gravity_y];

vq4 = [x_vq4-Center_of_gravity_x;...
       y_vq4-Center_of_gravity_y];

v1 = atand(-vq1(2)/vq1(1)); % atan(-y/x)
v2 = atand(vq2(1)/vq2(2)); % atand(x/y)
v3 = atand(-vq3(2)/vq3(1)); % atan(-y/x)
v4 = atand(vq4(1)/vq4(2)); % atand(x/y)     

% we define zero degrees to be where the sides of the cubes are alligned
% with the axes, but we find the degrees from the edges, and therefore
% (there is 45 degrees difference between an edge and):

v1 = v1 - 45;
v2 = v2 - 45;
v3 = v3 - 45;
v4 = v4 - 45;

if sum(abs([v1 v2 v3 v4]) >= 40) >= 2 
    rotation = 45;
else
    rotation = mean([v1,v2,v3,v4]);
end

end