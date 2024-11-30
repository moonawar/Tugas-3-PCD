% edge_roberts - Melakukan deteksi tepi dengan metode roberts

% parameter:
%   input: citra grayscale yang akan dideteksi tepinya
%   c: konstanta yang digunakan untuk menghitung gradien
% return
%   result: citra hasil deteksi tepi
function result = edge_roberts(input, c)
    % Menggunakan kernel roberts
    Gx = [1 0; 0 -1];
    Gy = [0 1; -1 0];

    % Menghitung gradien pada sumbu x dan y dengan kernel roberts
    gradX = util_conv(input, Gx) * c;
    gradY = util_conv(input, Gy) * c;

    % Menghitung magnitude gradien (menghasilkan intensitas tepi)
    result = sqrt(gradX.^2 + gradY.^2);
end

