function [boudingBox] = find_boudingBox(j,BLOB_output_img)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

% find the indexes of the BLOB
[I,J] = find(BLOB_output_img==j);

x_min = min(J);
x_max = max(J);
y_min = min(I);
y_max = max(I);

boudingBox = [x_min x_max y_min y_max];
end

