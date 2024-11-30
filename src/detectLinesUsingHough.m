function outputImage = detectLinesUsingHough(I)
    % Konversi ke citra grayscale
    if size(I, 3) == 3
        grayImage = rgb2gray(I);
    else
        grayImage = I;
    end

    % Duplikasi citra input awal
    outputImage = I;

    % Cek apakah citra yang diduplikasi adalah citra berwarna atau grayscale
    if size(outputImage, 3) == 1
        outputImage = cat(3, outputImage, outputImage, outputImage); % Convert to RGB
    end

    % Deteksi tepi dengan canny library
    edges = edge(grayImage, 'canny');

    % Lakukan Hough transform
    [H, theta, rho] = hough(edges);

    % Cari peaks
    peaks = houghpeaks(H, 10, 'threshold', ceil(0.3 * max(H(:))));

    % Cari garis 
    lines = houghlines(edges, theta, rho, peaks, 'FillGap', 20, 'MinLength', 30);

    % Looping untuk menggambarkan garis yang ditemukan pada gambar
    for k = 1:length(lines)
        xy = [lines(k).point1; lines(k).point2];

        % Gambar garisnya
        outputImage = insertShape(outputImage, 'Line', [xy(1, :) xy(2, :)], ...
                                  'Color', 'red', 'LineWidth', 2);

        % Mark the endpoints of the lines
        outputImage = insertMarker(outputImage, xy(1, :), 'x', 'Color', 'green', 'Size', 10);
        outputImage = insertMarker(outputImage, xy(2, :), 'x', 'Color', 'blue', 'Size', 10);
    end
end
