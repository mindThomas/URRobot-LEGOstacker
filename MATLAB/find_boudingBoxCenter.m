function boudingBoxCenter = find_boudingBoxCenter(boudingBox)
% boudingBox: [x_min x_max y_min y_max]
x_min = boudingBox(1);
x_max = boudingBox(2);
y_min = boudingBox(3);
y_max = boudingBox(4);

boudingBoxCenter = [x_min+(x_max-x_min)/2,...
                    y_min+(y_max-y_min)/2];
end

