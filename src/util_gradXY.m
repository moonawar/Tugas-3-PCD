% util_gradXY - Mendapatkan gradien pada sumbu x dan y

% parameter:
%   input: citra grayscale yang akan dideteksi tepinya
%   c: konstanta yang digunakan untuk menghitung gradien
% return
%   Gx: gradien pada sumbu x
%   Gy: gradien pada sumbu y
function [Gx, Gy] = util_gradXY(input, c)
    % Kernel untuk mendapatkan gradien pada sumbu x dan y
    kernel_x = [-1, 0, 1; -c, 0, c; -1, 0, 1];
    kernel_y = [-1, -c, -1; 0, 0, 0; 1, c, 1];

    % Konvolusi citra input dengan kernel gradien
    Gx = util_conv(input, kernel_x);
    Gy = util_conv(input, kernel_y);
end