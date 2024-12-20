% edge_canny - Melakukan deteksi tepi dengan metode canny

% parameter:
%   input: citra grayscale yang akan dideteksi tepinya
%   sigma: nilai sigma untuk gaussian kernel
%   th: threshold untuk tepi kuat (0-1)
% return
%   result: citra hasil deteksi tepi
function result = edge_canny(input, sigma, th)
    % Filter menggunakan gaussian kernel
    gaussFiltered = util_gaussFilter(input, 5, sigma);
    [Gx, Gy] = util_gradXY(gaussFiltered, 2);

    % Menghitung magnitude dan arah gradien
    magnitude = sqrt(Gx.^2 + Gy.^2);
    grad_angle = atan2(Gy, Gx) * 180 / pi;
    grad_angle(grad_angle < 0) = grad_angle(grad_angle < 0) + 180;

    [rows, cols] = size(input);

    % Non-maximum suppression
    surpressed = zeros(rows, cols);

    % Kelompokkan arah gradien
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
            
            % Jika local maximum, maka simpan nilai magnitude
            if (magnitude(i,j) >= q && magnitude(i,j) >= r)
                surpressed(i,j) = magnitude(i,j);
            else % Jika tidak, maka nilai 0
                surpressed(i, j) = 0;
            end
        end
    end

    % Hysteresis thresholding
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
                % Jika ada tepi kuat di sekitar, maka jadikan tepi lemah menjadi kuat
                if (any(edges(i-1:i+1, j-1:j+1) == strong))
                    edges(i,j) = strong;
                else % Jika tidak, maka jadikan tepi lemah menjadi 0
                    edges(i,j) = 0;
                end
            end
        end
    end

    result = edges;
end

