function outputImage = detectCirclesUsingHough(I)
    % Konversi citra ke citra grayscale
    if size(I, 3) == 3
        grayImage = rgb2gray(I);
    else
        grayImage = I;
    end

    % Duplikasi citra untuk visualisasi
    outputImage = I;

    % Cek apakah citra yang diduplikasi adalah citra berwarna atau tidak
    if size(outputImage, 3) == 1
        outputImage = cat(3, outputImage, outputImage, outputImage); % Convert to RGB
    end

    % Cari citra tepi
    edges = edge(grayImage, 'canny');

    % Deteksi lingkaran dengan Hough transform berdasarkan parameter yang telah ditetapkan
    [centers, radii, metric] = imfindcircles(edges, [50 100], ...
                                             'Sensitivity', 0.9, ...
                                             'EdgeThreshold', 0.1);

    % Gambarkan lingkaran yang didapat pada citra
    for i = 1:length(centers)
        % Lingkaran yang ditemukan
        outputImage = insertShape(outputImage, 'Circle', ...
                                  [centers(i, :) radii(i)], ...
                                  'Color', 'yellow', 'LineWidth', 5);

        % Pusat lingkaran yang ditemukan
        outputImage = insertMarker(outputImage, centers(i, :), 'x', ...
                                   'Color', 'red', 'Size', 10);
    end
end
