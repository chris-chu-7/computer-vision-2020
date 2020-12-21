 function index_map = generateIndexMap(gray_stack, w_size)
    [H, W, N] = size(gray_stack);
    index_map = uint8(zeros(H, W));
    
    % Compute the focus measure -- the sum-modified laplacian
    %
    % horizontal Laplacian kernel
    Kx = [0.25 0 0.25;...
           1  -3   1; ...
          0.25 0 0.25];
    Ky = Kx';   % vertical version
    
    % horizontal and vertical Laplacian responses
    Lx = zeros(H, W, N);
    Ly = zeros(H, W, N);
    for n = 1:N
        I = im2double(gray_stack(:,:,n));
        Lx(:,:,n) = imfilter(I, Kx, 'replicate', 'same', 'corr');
        Ly(:,:,n) = imfilter(I, Ky, 'replicate', 'same', 'corr');
    end
    
    % sum-modified Laplacian
    SML = (abs(Lx) .^ 2) + (abs(Ly) .^ 2);
    % can also use the absolute value itself
    % this is probably more well-known
    % SML = abs(Lx) + abs(Ly);
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % ADD YOUR CODE HERE
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %Moving Average Filter Here.
    disp("showing...");
    movingavg = movmean(SML, 0.5);
    %imshow(uint8(movingavg(:, :, 1)));   
    
   % disp(size(gray_stack));
    %For All indices, Point towards the maximum.
    stack_size = size(SML);
    
    rows = stack_size(1);
    cols = stack_size(2);
    pics = stack_size(3); 
    
    %select the maximum value(s) from the focus measures. 
    for i = 1 : rows
        for j = 1: cols
            maxIndex = 1;
            for k = 1 : pics
               if(movingavg(i, j, k) > movingavg(i, j, maxIndex))
                   maxIndex = k;
               end
            end
            index_map(i, j) = maxIndex;
        end
    end
    
    disp(index_map);

  
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end