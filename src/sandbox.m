input = imread('../images/car.jpg');
gray = rgb2gray(input);
gray = im2double(gray);

figure, imshow(input), title("Input Image");

canny_edge = edge(gray, "canny");
figure, imshow(canny_edge), title("Output Canny");

canny_segmented = segment_object(input, canny_edge);
figure, imshow(canny_segmented), title("Output Object Segmentation with Canny");