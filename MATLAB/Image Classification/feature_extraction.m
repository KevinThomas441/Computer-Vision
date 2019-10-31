function feat = feature_extraction(img)
% Output should be a fixed length vector [1*dimension] for a single image. 
% Please do NOT change the interface.
% feat = rand([1,100]); % dummy, replace this with your algorithm
img = rgb2gray(img);
image_size = size(img);

%img = imadjust(img);

img = imgaussfilt(img, 0.95);

%img = edge(img, 'Sobel');

%rows = image_size(1);
%columns = image_size(2);
%dimension = rows * columns;

%[features] = extractHOGFeatures(img, 'NumBins', 20);
%points = detectSURFFeatures(img);
%[features, ~] = extractFeatures(img, points, 'Method', 'SURF');

[features] = extractLBPFeatures(img, 'NumNeighbors', 8, 'CellSize', (image_size/4));

%features = reshape(img, [1, dimension]);
feat = features;
end