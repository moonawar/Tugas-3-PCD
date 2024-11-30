% edge_sobel - Melakukan deteksi tepi dengan metode sobel

% parameter:
%   input: citra grayscale yang akan dideteksi tepinya
%   c: konstanta yang digunakan untuk menghitung gradien
% return
%   result: citra hasil deteksi tepi
function result = edge_sobel(input, c)
    % Mendapatkan gradien pada sumbu x dan y
    [Gx, Gy] = util_gradXY(input, c);

    % Menghitung magnitude gradien (menghasilkan intensitas tepi)
    result = sqrt(Gx.^2 + Gy.^2);
end