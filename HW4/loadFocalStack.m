function [rgb_stack, gray_stack] = loadFocalStack(focal_stack_dir)

    cd(focal_stack_dir);
    listing = dir;
    k = length(listing) - 2;
    disp(listing);
    img = imread(listing(3).name);
    
    img_size = size(img); 
    m = img_size(1);
    n = img_size(2);
    rgb_stack = uint8(zeros(m,n,3*k));
    gray_stack = uint8(zeros(m,n,k));
 
    for itr = 3 : 1 : k + 2
        read = imread(listing(itr).name);
        rgbfrom = 3*itr-9+1;
        rgbto = 3*(itr-2);
        gray_stack(:, :, itr - 2) = rgb2gray(read);
        rgb_stack(:,:,rgbfrom:rgbto) = read; 
    end
    
    cd ..;
    