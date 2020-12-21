function refocusApp(rgb_stack, depth_map)
    imshow(rgb_stack(:,:,1:3))
    stack_size = size(rgb_stack);
    xs = stack_size(1);
    ys = stack_size(2);
    disp("Click Anywhere in the image...");
    %display the image
    [x,y] = ginput(1);
    while ceil(x) <= xs && ceil(y) <= ys
            findImage = depth_map(ceil(y), ceil(x));
            imshow(rgb_stack(:, :, (3 * findImage - 2 : 3 * findImage)));
            pause(1);
            disp("click anywhere in the image...");
            [x,y] = ginput(1);
    end
    
    disp("while loop exited");
    
    
   %try to find the optimal point inside of the image.
    
    