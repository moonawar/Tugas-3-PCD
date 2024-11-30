% edge_prewitt - Melakukan deteksi tepi dengan metode prewitt

% parameter:
%   input: citra grayscale yang akan dideteksi tepinya
% return
%   result: citra hasil deteksi tepi
function result = edge_prewitt(input)
    % Sama dengan edge_sobel, hanya saja menggunakan konstanta 1
    result = edge_sobel(input, 1);
end