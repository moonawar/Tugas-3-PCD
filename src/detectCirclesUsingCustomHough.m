function outputImage = detectCirclesUsingCustomHough(I)
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

    % Tentukan radius lingkaran yang akan dideteksi
    radiusRange = 50:100; % Sesuaikan rentang radius
    [rows, cols] = size(edges);

    % Inisialisasi akumulator Hough
    houghSpace = zeros(rows, cols, length(radiusRange));

    % Hough Transform untuk Lingkaran
    for rIdx = 1:length(radiusRange)
        radius = radiusRange(rIdx);
        for x = 1:rows
            for y = 1:cols
                if edges(x, y) % Jika titik adalah tepi
                    for theta = 0:1:359 % Iterasi melalui sudut 0-359 derajat
                        a = round(x - radius * cosd(theta));
                        b = round(y - radius * sind(theta));
                        if a > 0 && a <= rows && b > 0 && b <= cols
                            houghSpace(a, b, rIdx) = houghSpace(a, b, rIdx) + 1;
                        end
                    end
                end
            end
        end
    end

    % Cari puncak di Hough Space
    threshold = 0.7 * max(houghSpace(:)); % Sesuaikan threshold
    [a, b, rIdx] = ind2sub(size(houghSpace), find(houghSpace > threshold));

    % Gambarkan lingkaran yang didapat pada citra
    for i = 1:length(a)
        radius = radiusRange(rIdx(i));
        center = [b(i), a(i)];

        % Gambar lingkaran yang ditemukan
        outputImage = insertShape(outputImage, 'Circle', [center, radius], ...
                                  'Color', 'yellow', 'LineWidth', 5);

        % Tandai pusat lingkaran yang ditemukan
        outputImage = insertMarker(outputImage, center, 'x', ...
                                   'Color', 'red', 'Size', 10);
    end
end
