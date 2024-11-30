% segment_object - Melakukan segmentasi objek pada citra berdasarkan citra tepi

% parameter:
%   original_image: citra asli yang akan diolah
%   edge_image: citra tepi yang digunakan sebagai acuan segmentasi
% return
%   result: citra hasil segmentasi
function [mask, result] = segment_object(original_image, edge_image)
    % Tutup kontur objek dengan cara mengisi celah-celah kecil dengan garis
    closed = imclose(edge_image, strel('line', 3, 90)); % vertikal
    closed = imclose(closed, strel('line', 3, 0)); % horizontal
    closed = imclose(closed, strel('line', 3, 45)); % diagonal
    % figure, imshow(closed), title("Output Closed");

    % Fill kontur objek dengan cara mengisi area yang dikelilingi garis dengan warna putih
    filled = imfill(closed, 'holes');
    % figure, imshow(filled), title("Output Filled");

    % Erosi untuk mengurangi noise
    eroded = imerode(filled, strel('disk', 3));
    % figure, imshow(eroded), title("Output Eroded");

    % Menghilangkan noise dengan menghapus region-region kecil
    reduced = bwareaopen(eroded, 1500);
    % figure, imshow(reduced), title("Output Reduced");

    % Hasil tersebut akan digunakan sebagai mask untuk segmentasi
    mask = reduced;
    % figure, imshow(mask), title("Final Mask");

    % figure, imshow(original_image), title("Original Image");

    % Segmentasi objek dengan mengalikan citra asli dengan mask
    channel_amount = size(original_image, 3);
    result = original_image;
    for i = 1:channel_amount
        result(:, :, i) = original_image(:, :, i) .* uint8(mask);
    end
    % figure, imshow(result), title("Output Segmented");
end

