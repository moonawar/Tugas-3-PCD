% Meminta input nama file citra dari pengguna
imageName = input('Masukkan nama file citra (contoh: "road1.png"): ', 's');

% Membaca citra dari direktori yang sama
imagePath = fullfile('../images', imageName);
I = imread(imagePath);

% Konversi ke citra grayscale
if size(I, 3) == 3
    grayImage = rgb2gray(I);
else
    grayImage = I;
end

% Deteksi tepi dengan Canny
edges = edge(grayImage, 'canny');

% Komparasi hasil Hough Transform
detectedCirclesImage = detectCirclesUsingHough(I);
detectedCirclesImage2 = detectCirclesUsingCustomHough(I);

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

% Subplot 3: Hough Transform untuk Lingkaran (Library)
subplot(2, 2, 3);
imshow(detectedCirclesImage);
title('Hough Transform untuk Lingkaran (Library)');

% Subplot 4: Hough Transform untuk Lingkaran (Implementasi Sendiri)
subplot(2, 2, 4);
imshow(detectedCirclesImage2);
title('Hough Transform untuk Lingkaran (Implementasi Sendiri)');
