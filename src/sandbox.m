input = imread('../images/log.png');
input = rgb2gray(input);
input = im2double(input);

output = edge_log(input, 5, 1);
figure;
imshow(output);