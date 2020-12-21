%%Load, resize, and display images
%%matlab has some built-in images that you can just load. 
tic;
img1 = imread('flamingos.jpg');
img2 = imread('onion.png');
img3 = imread('llama.jpg');


clf;
imshow(img1);

% hange the images to double precision
img1 = im2double(img1);
img2 = im2double(img2);
img3 = im2double(img3);

%make all images grayscale
img1 = rgb2gray(img1);
img2 = rgb2gray(img2);
img3 = rgb2gray(img3);

%make all of the images the same size
n_rows = 256;
n_cols = 256;

img1 = imresize(img1, [n_rows, n_cols]);
img2 = imresize(img2, [n_rows, n_cols]);
img3 = imresize(img3, [n_rows, n_cols]);

clf;

%display all images in figure
subplot(1,3,1);
imshow(img1);
title('img1');

subplot(1,3,2);
imshow(img2);
title('img1');


subplot(1,3,3);
imshow(img3);
title('img3');

%gradient
%an image gradient is a directional change in the intensity/color
%of an image

%image gradients are basic building block of more advanced computer
%vision algorithms

%There are many ways to take this image gradient.
%take difference between adjacent pixels. 
%let f(y,x) be in image, y = rows, x = columns
% gradient in x diretion df/dx = f(y, x + 1) - f(y, x)
% gradient in y direction df/dy = f(y + 1, x) - f(y, x) 
% gradient magnitude [df/dx] = sqrt((df/dx^2) + (df/dy^2))





img = img1;
grad_x_img = zeros(size(img));
grad_y_img = zeros(size(img));
grad_magnitude_img = zeros(size(img));

for y = 1: n_rows - 1
    for x = 1:n_cols - 1
        grad_x = img(y, x + 1) - img(y, x);
        grad_y = img(y + 1, x) - img(y, x);
        grad_magnitude = sqrt((grad_x ^2) + (grad_y ^ 2));
        grad_x_img(y,x) = grad_x;
        grad_y_img(y,x) = grad_y;
        grad_magnitude_img(y,x) = grad_magnitude;
    end
end

grad_y_img(1:n_rows - 1, :) = img(2:end, :) - img(1:end - 1, :);
grad_x_img(:, 1:n_cols - 1) = img(:, 2:end) - img(:, 1:end - 1);

[grad_y_img, grad_x_img, grad_magnitude_img] = img_gradient(img);

clf;
subplot(1,4,1);
imshow(img); 
title('img');

subplot(1,4,2);
imshow(grad_x_img * 5);
title('x gradient');

subplot(1,4,3);
imshow(grad_y_img * 5);
title('y gradient');

subplot(1,4,4);
%multiply by 5 to improve the visualization. 

imshow(grad_magnitude_img * 5);
title('gradient magnitude');
toc;