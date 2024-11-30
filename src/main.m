% Meminta input nama file citra dari pengguna
imageName = input('Masukkan nama file citra (contoh: "road 1.png"): ', 's');

% Membaca citra dari direktori yang sama
imagePath = fullfile('../images', imageName);
I = imread(imagePath);

% Konversi ke citra grayscale
if size(I, 3) == 3
    grayImage = rgb2gray(I);
else
    grayImage = I;
end

% Deteksi tepi dengan canny library
edges = edge(grayImage, 'canny');

% Komparasi hasil Hough Transform
detectedImage = detectLinesUsingHough(I);
detectedImage2 = detectLinesUsingCustomHough(I);

% Tampilkan dalam subplot
figure('Position', [200, 100, 1500, 800]);

% Subplot 1: Citra input
subplot(2, 2, 1);
imshow(I);
title('Citra input');

% Subplot 2: Citra tepi
subplot(2, 2, 2);
imshow(edges);
title('Citra tepi');

% Subplot 3: Hough Transform (Library)
subplot(2, 2, 3);
imshow(detectedImage);
title('Hough Transform (Library)');

% Subplot 4: Hough Transform (Implementasi Sendiri)
subplot(2, 2, 4);
imshow(detectedImage2);
title('Hough Transform (Implementasi Sendiri)');
