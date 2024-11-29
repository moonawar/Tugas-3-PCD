function result = edge_canny(input, sigma, th)
    gaussFiltered = util_gaussFilter(input, 5, sigma); % using 5x5 gaussian kernel
    [Gx, Gy] = util_gradXY(gaussFiltered, 2);

    magnitude = sqrt(Gx.^2 + Gy.^2);
    grad_angle = atan2(Gy, Gx) * 180 / pi;
    grad_angle(grad_angle < 0) = grad_angle(grad_angle < 0) + 180;

    [rows, cols] = size(input);
    surpressed = zeros(rows, cols); % edge with only local maxima
    angle_group = zeros(rows, cols);

    angle_group((grad_angle >= 0 & grad_angle < 22.5) | (grad_angle >= 157.5)) = 0;
    angle_group(grad_angle >= 22.5 & grad_angle < 67.5) = 45;
    angle_group(grad_angle >= 67.5 & grad_angle < 112.5) = 90;
    angle_group(grad_angle >= 112.5 & grad_angle < 157.5) = 135;

    for i = 2:rows-1
        for j = 2:cols-1
            q = 0;
            r = 0;

            switch (angle_group(i,j))
                case 0
                    q = magnitude(i, j+1);
                    r = magnitude(i, j-1);
                case 135
                    q = magnitude(i-1, j+1);
                    r = magnitude(i+1, j-1);
                case 90
                    q = magnitude(i-1, j);
                    r = magnitude(i+1, j);
                case 45
                    q = magnitude(i-1, j-1);
                    r = magnitude(i+1, j+1);
            end
            
            if (magnitude(i,j) >= q && magnitude(i,j) >= r)
                surpressed(i,j) = magnitude(i,j);
            else
                surpressed(i, j) = 0;
            end
        end
    end

    Th = th;
    Tl = 0.5 * Th;

    edges = zeros(rows, cols);
    strong = 1;
    weak = 0.4;

    edges(surpressed >= Th) = strong;
    edges(surpressed >= Tl & surpressed < Th) = weak;

    for i = 2:rows-1
        for j = 2:cols-1
            if (edges(i,j) == weak)
                if (any(edges(i-1:i+1, j-1:j+1) == strong)) % if connected to any strong neighbour
                    edges(i,j) = strong;
                else
                    edges(i,j) = 0;
                end
            end
        end
    end

    result = edges;
end