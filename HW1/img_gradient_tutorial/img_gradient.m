function [grad_y_img, grad_x_img, grad_magnitude_img] = img_gradient(img)
    grad_x_img = zeros(size(img));
    grad_y_img = zeros(size(img));
    grad_y_img(1:end - 1, :) = img(2:end, :) - img(1:end - 1, :);
    grad_x_img(:, 1:end - 1) = img(:, 2:end) - img(:, 1:end - 1);
    grad_magnitude_img = sqrt((grad_x_img .^ 2) + (grad_y_img .^ 2));
end


