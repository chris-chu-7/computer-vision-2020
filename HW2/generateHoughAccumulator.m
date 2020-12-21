function hough_img = generateHoughAccumulator(img, theta_num_bins, rho_num_bins)
    imshow(img)
    [rows, columns] = size(img);
    img2 = zeros(rows, columns);
    theta_range = -90 : 90;
    rho_range = -sqrt(rows ^ 2 + columns ^ 2) : sqrt(rows ^ 2 + columns ^ 2);
    max_rho = floor(sqrt(rows ^ 2 + columns ^ 2));
    max_theta = 90;
    accum = zeros(length(rho_range), length(theta_range));    
    for row = 1 : rows
        for column = 1 : columns
            for theta = theta_range
                rho = round(((row - 1) * cosd(theta)) - ((column - 1) * sind(theta))); 
                accum(rho + 1 + max_rho, theta + 1 + max_theta) = accum(rho + 1 + max_rho, theta + 1 + max_theta) + 1; 
            end
        end
    end
  
    
    for rho = rho_range
        for theta = theta_range
            %disp(rho)
            %disp(theta) 
            x_coord = round(rho * cosd(theta));
            y_coord = round(rho * sind(theta));
            %disp(x_coord + " xcoord");
            %disp(y_coord + " ycoord")
            if(x_coord >= 1)
                if(y_coord >= 1)
                    if(x_coord < rows)
                        if(y_coord < columns)
                    %disp(round(rho + 2 + max_rho) + " maxrho");
                    %disp(round(theta + 1 + max_theta) + " maxtheta");
                        img2(x_coord + 1, y_coord + 1) = accum(round(rho + 2 + max_rho), round(theta + 1 + max_theta));
                        if img2(x_coord + 1, y_coord + 1)> 0
                            disp("witch" + img2(x_coord + 1, y_coord + 1));
                        end
                        
                        end 
                    end
                    
                end
            end
            
        end
    end
    disp(img2);
    hough_img = img2;
end

 