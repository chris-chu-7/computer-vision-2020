function [inliers_id, H] = runRANSAC(Xs, Xd, ransac_n, eps)
%RUNRANSAC
    num_pts = size(Xs, 1);
    num_fit = 0;
    pts_id = 1:num_pts;
    inliers_id = [];
    
    for iter = 1:ransac_n
        % ---------------------------
        % START ADDING YOUR CODE HERE
        % ---------------------------
        samples = size(Xs,1);
        disp(samples);
        
        %Randomly choose 4 numbers
        random_number = randi(samples, 4, 1);
        random_source = Xs(random_number, :);
        random_destination = Xd(random_number, :);
        
        %Fit the model to these randomly chosen samples. 
        homography = computeHomography(random_source, random_destination);
        Xd_map = applyHomography(homography,Xs);
        eu_dist = ((Xd(:,1) - Xd_map(:,1)).^2 + (Xd(:,2) - Xd_map(:,2)).^2).^(0.5);
        
        %Try to find values within ?
        values = find (eu_dist < eps);
        
        if length(values) > num_fit
            num_fit = length(values);
            H = homography;
            inliers_id = values;
        end
        
        
        
        % ---------------------------
        % END ADDING YOUR CODE HERE
        % ---------------------------
    end    
end
