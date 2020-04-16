function [testLabels,predictedLabels]=hog1(testSet1,cellSize,hogFeatureSize,classifier)
numImages = numel(testSet1.Files);
testFeatures = zeros(numImages, hogFeatureSize, 'single');
for i = 1:numImages
    img = readimage(testSet1, i);
    img = rgb2gray(img);
    % Apply pre-processing steps
    img = imbinarize(img);
    testFeatures(i, :) = extractHOGFeatures(img, 'CellSize', cellSize);  
end
% Get labels for each image.
testLabels = testSet1.Labels;
predictedLabels = predict(classifier, testFeatures);
end