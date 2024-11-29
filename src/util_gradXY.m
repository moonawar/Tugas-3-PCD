function [Gx, Gy] = util_gradXY(input, c)
    kernel_x = [-1, 0, 1; -c, 0, c; -1, 0, 1];
    kernel_y = [-1, -c, -1; 0, 0, 0; 1, c, 1];

    Gx = util_conv(input, kernel_x);
    Gy = util_conv(input, kernel_y);
end