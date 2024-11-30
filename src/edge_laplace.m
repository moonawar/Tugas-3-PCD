% edge_laplace - Melakukan deteksi tepi dengan metode laplace (turunan kedua)

% parameter:
%   input: citra grayscale yang akan dideteksi tepinya
% return 
%   result: citra hasil deteksi tepi
function result = edge_laplace(input)
    % kernel laplace yang diturunkan berdasarkan turunan kedua
    laplace_kernel = [1, 1, 1; 1, -8, 1; 1, 1, 1];

    % konvolusi citra input dengan kernel laplace
    result = util_conv(input, laplace_kernel);
end