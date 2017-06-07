function [ bricks ] = blobAnalysis( binaryImage,config )
    %% BLOB Analysis
    % We use a grassfire algorithm 4-connectivity because it is faster than 
    % 8-connectivity, and all the bricks are we are trying to find do not
    % have any holes!
    
    global tmp_BLOB_input_img
    tmp_BLOB_input_img = binaryImage;
    
    global tmp_BLOB_output_img
    tmp_BLOB_output_img = zeros(size(binaryImage));
    
    n_obj = 0;
    
    for n = 1 : size(tmp_BLOB_input_img,1)
            for m = 1 : size(tmp_BLOB_input_img,2)
                if tmp_BLOB_input_img(n,m) == 1        
                    tmp_BLOB_input_img(n,m) = 0;
                    
                    n_obj = n_obj+1;
                    tmp_BLOB_output_img(n,m) = n_obj;
                    BLOB_recursive(n,m,n_obj);
                end
            end
    end
    
    N_obj = n_obj; % save number of objects in each image
    
    BLOB_output_img = tmp_BLOB_output_img;
    
    %% BLOB features
    % BLOB features 7.2...
    % in this process we remove all BLOBS with to little mass!
    %mass_min = 3500; % minimum mass of BLOB to be recognized as a brick

    brickStruct =  struct('identifier',[],...
                          'boudingBox',[],... %[x_min x_max y_min y_max]
                          'boudingBoxCenter',[],...
                          'mass',[],...
                          'rotation',[],...
                          'Center_of_gravity',[]);

    bricks = {};
    i = 1;
    for j = 1:N_obj
        if find_mass(j,BLOB_output_img) > config.mass_min
            bricks{i} = brickStruct; 
            bricks{i}.identifier = j;
            bricks{i}.boudingBox = find_boudingBox(j,BLOB_output_img);
            bricks{i}.boudingBoxCenter = find_boudingBoxCenter(bricks{i}.boudingBox);
            bricks{i}.mass = find_mass(j,BLOB_output_img);
            bricks{i}.Center_of_gravity = find_center_of_mass(j,BLOB_output_img);
            bricks{i}.rotation = find_rotation2(j,BLOB_output_img,bricks{i}.Center_of_gravity);
     
            i = i+1;
        end
    end 
end

