function [] = BLOB_recursive(n,m,obj)
global tmp_BLOB_input_img
global tmp_BLOB_output_img

if m ~= size(tmp_BLOB_input_img,2)
    if tmp_BLOB_input_img(n,m+1) == 1
        tmp_BLOB_input_img(n,m+1) = 0;
        tmp_BLOB_output_img(n,m+1) = obj;
        BLOB_recursive(n,m+1,obj);
    end
end 

if n ~= size(tmp_BLOB_input_img,1)
    if tmp_BLOB_input_img(n+1,m) == 1
        tmp_BLOB_input_img(n+1,m) = 0;
        tmp_BLOB_output_img(n+1,m) = obj;
        BLOB_recursive(n+1,m,obj);
    end
end

if m ~= 1
    if tmp_BLOB_input_img(n,m-1) == 1
        tmp_BLOB_input_img(n,m-1) = 0;
        tmp_BLOB_output_img(n,m-1) = obj;
        BLOB_recursive(n,m-1,obj);
    end 
end

if n ~= 1
    if tmp_BLOB_input_img(n-1,m) == 1
        tmp_BLOB_input_img(n-1,m) = 0;
        tmp_BLOB_output_img(n-1,m) = obj;
        BLOB_recursive(n-1,m,obj);   
    end
end
    
end

