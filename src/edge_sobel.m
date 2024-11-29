function result = edge_sobel(input, c)
    [Gx, Gy] = util_gradXY(input, c);
    result = sqrt(Gx.^2 + Gy.^2);
end