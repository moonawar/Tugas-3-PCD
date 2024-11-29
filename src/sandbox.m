input = imread('../images/canny.png');
input = rgb2gray(input);
input = im2double(input);

% output = edge_sobel(input, 2);
% figure;
% imshow(output);

% output = edge_prewitt(input);
% figure;
% imshow(output);

output = edge(input, "canny");
figure, imshow(output), title("Output Canny Built-in");

output = edge_canny(input, 1.4, 0.4);
figure, imshow(output), title("Output Canny");