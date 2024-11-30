function outputImage = detectLinesUsingCustomHough(I)
    % Konversi ke citra grayscale
    if size(I, 3) == 3
        grayImage = rgb2gray(I);
    else
        grayImage = I;
    end

    % Menggambar garis yang terdeteksi
    outputImage = I;

    % Periksa apakah citra grayscale atau RGB
    if size(outputImage, 3) == 1
        outputImage = cat(3, outputImage, outputImage, outputImage); % Konversi ke RGB
    end

    % Deteksi tepi menggunakan metode Canny
    edges = edge(grayImage, 'canny');

    % Parameter yang digunakan dalam transformasi Hough
    [height, width] = size(edges);
    diagonal = round(sqrt(height^2 + width^2)); % Panjang diagonal maksimum (rho maksimum)
    rhoRange = -diagonal:1:diagonal;           % Nilai-nilai rho
    thetaRange = -90:1:89;                     % Nilai-nilai theta dalam derajat
    accumulator = zeros(length(rhoRange), length(thetaRange)); % Akumulator Hough

    % Mengisi akumulator
    for y = 1:height
        for x = 1:width
            if edges(y, x) % Jika piksel merupakan tepi
                for thetaIndex = 1:length(thetaRange)
                    theta = deg2rad(thetaRange(thetaIndex));
                    rho = round(x * cos(theta) + y * sin(theta));
                    rhoIndex = find(rhoRange == rho);
                    if ~isempty(rhoIndex)
                        accumulator(rhoIndex, thetaIndex) = accumulator(rhoIndex, thetaIndex) + 1;
                    end
                end
            end
        end
    end

    % Menemukan puncak dalam akumulator secara manual
    peakThreshold = 0.1 * max(accumulator(:)); % Ambang batas untuk deteksi puncak
    peaks = [];
    neighborhoodSize = 50; % Ukuran lingkungan untuk supresi non-maksimum

    for i = 1:size(accumulator, 1)
        for j = 1:size(accumulator, 2)
            if accumulator(i, j) > peakThreshold
                % Periksa apakah merupakan maksimum lokal
                localRegion = accumulator(max(1, i-neighborhoodSize):min(size(accumulator, 1), i+neighborhoodSize), ...
                                          max(1, j-neighborhoodSize):min(size(accumulator, 2), j+neighborhoodSize));
                if accumulator(i, j) == max(localRegion(:))
                    peaks = [peaks; i, j]; %#ok<AGROW>
                end
            end
        end
    end

    % Menemukan segmen tepi yang terhubung
    labeledEdges = bwlabel(edges);
    edgeProps = regionprops(labeledEdges, 'PixelList');

    % Mengonversi puncak ke (rho, theta) dan menggambar garis
    for k = 1:size(peaks, 1)
        rhoIndex = peaks(k, 1);
        thetaIndex = peaks(k, 2);

        rho = rhoRange(rhoIndex);
        theta = deg2rad(thetaRange(thetaIndex));

        % Mengidentifikasi cluster tepi yang sesuai
        for e = 1:length(edgeProps)
            pixelList = edgeProps(e).PixelList;
            distances = abs(pixelList(:, 1) * cos(theta) + pixelList(:, 2) * sin(theta) - rho);

            % Jika cluster tepi berada pada garis, gambarkan
            if mean(distances) < 2 % Toleransi untuk kecocokan garis
                for p = 1:size(pixelList, 1) - 1
                    x1 = pixelList(p, 1);
                    y1 = pixelList(p, 2);
                    x2 = pixelList(p+1, 1);
                    y2 = pixelList(p+1, 2);

                    % Gambar segmen tepi
                    outputImage = insertShape(outputImage, 'Line', [x1, y1, x2, y2], ...
                                              'Color', 'red', 'LineWidth', 2);
                end
            end
        end
    end
end
