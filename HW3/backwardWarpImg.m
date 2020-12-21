function [mask, result_img] = backwardWarpImg(src_img, resultToSrc_H,...
                                              dest_canvas_width_height)
                                          
	src_height = size(src_img, 1);
	src_width = size(src_img, 2);
    src_channels = size(src_img, 3);
    
    dest_width = dest_canvas_width_height(1);
	dest_height	= dest_canvas_width_height(2);
    
    result_img = zeros(dest_height, dest_width, src_channels);
    mask = false(dest_height, dest_width);
    
  %  disp("mask" + size(mask));
  %  disp("src_img" + size(src_img));
  %  disp("result to source" + size(resultToSrc_H));
    
    % this is the overall region covered by result_img
    [dest_X, dest_Y] = meshgrid(1:dest_width, 1:dest_height);
  %  disp("dest X" + dest_X);
   % disp("dest Y" + dest_Y);


    
    
    % map result_img region to src_img coordinate system using the given
    % homography.
    src_pts = applyHomography(resultToSrc_H, [dest_X(:), dest_Y(:)]);
    src_X = reshape(src_pts(:,1), dest_height, dest_width);
    src_Y = reshape(src_pts(:,2), dest_height, dest_width);
    
   % disp("src_pts" + size(src_pts, 1));
    %disp("src_pts" + size(src_pts, 2));
   % disp("src_x" + src_X);
    %disp("src_y" + (src_Y));
    
    %disp("src_pts" + size(src_pts));
    % ---------------------------
    % START ADDING YOUR CODE HERE
    % ---------------------------
    disp("homography");
    disp(resultToSrc_H);
    
    
    
    % Set 'mask' to the correct values based on src_pts.
    disp(size(src_img));
    for width = 1 : src_width
        for height = 1 : src_height
            if src_X(height,width) > 0 && src_X(height, width) <= 640 
                if src_Y(height,width) > 0 && src_Y(height, width) <= 460
                    mask(height, width) = 1;
                 end
            end        
        end
    end
    
    
    imshow(result_img);
    
    
    % fill the right region in 'result_img' with the src_img
%    newImage(:,:,2) = interp2(src_img, dest_img, double(mask), srcX, srcY); 
    for height = 1 : src_height
        for  width = 1 : src_width
           
            if(mask(height, width) == 1)
                %X = src_X(height, width)
                %Y = src_Y(height, width)
                %disp("Height: " + height);
                %disp("Width: " + width);
                %disp("----------------------");
                %disp("Red "+ interp2(src_img(:, :, 1), src_X(height, width), src_Y(height, width)));
                %disp("Green "+ interp2(src_img(:, :, 2), src_X(height, width), src_Y(height, width)));
                %disp("Blue "+ interp2(src_img(:, :, 3), src_X(height, width), src_Y(height, width)));
                result_img(ceil(src_X(height, width)), ceil(src_Y(height, width)), 1) = interp2(src_img(:, :, 1), src_X(height, width), src_Y(height, width));
                result_img(ceil(src_X(height, width)), ceil(src_Y(height, width)), 2) = interp2(src_img(:, :, 2), src_X(height, width), src_Y(height, width));
                result_img(ceil(src_X(height, width)), ceil(src_Y(height, width)), 3) = interp2(src_img(:, :, 3), src_X(height, width), src_Y(height, width));
                disp(".");
                %disp(".");
                %disp(".");


            end
        end
    end
    
    imshow(result_img);
    disp("Done!");
    
      
    % ---------------------------
    % END YOUR CODE HERE    
    % ---------------------------
end