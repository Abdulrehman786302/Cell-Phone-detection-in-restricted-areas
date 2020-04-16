function [classifier,hogFeatureSize,cellSize]=hog(img,trainingSet1) 
% Extract HOG features and HOG visualization
[hog_16x16, vis16x16] = extractHOGFeatures(img,'CellSize',[16 16]);
[hog_32x32,vis32x32] = extractHOGFeatures(img,'CellSize',[32 32]);
[hog_64x64,vis64x64] = extractHOGFeatures(img,'CellSize',[64 64]);
% Show the original image 
subplot(2,3,1:3); imshow(img);
title('Sample for training');
% Visualize the HOG features
subplot(2,3,4);  
plot(vis16x16); 
title({'CellSize = [16 16]'; ['Length = ' num2str(length(hog_16x16))]});
subplot(2,3,5);
plot(vis32x32); 
title({'CellSize = [32 32]'; ['Length = ' num2str(length(hog_32x32))]});
subplot(2,3,6);
plot(vis64x64); 
title({'CellSize = [64 64]'; ['Length = ' num2str(length(hog_64x64))]});
%identify the optimal parameter settings.
cellSize = [32 32];
hogFeatureSize = length(hog_32x32);
figure(6)
subplot(211)
imshow(img);
title('Sample for training');
subplot(212);
plot(vis32x32); 
title({'CellSize = [32 32]'; ['Length = ' num2str(length(hog_32x32))]; 'Best Cell size'});
%Start by extracting HOG features from the training set. These features will be used to train the classifier.
% The trainingSet is an array of 2 imageSet objects
% Loop over the trainingSet and extract HOG features from each image. A
% similar procedure will be used to extract features from the testSet.
trainingFeatures = [];
trainingLabels   = [];
for pic = 1:numel(trainingSet1)
      numImages = trainingSet1(pic).Count;
      features  = zeros(numImages, hogFeatureSize, 'single');
      for i = 1:numImages
          img = read(trainingSet1(pic), i);
          img=rgb2gray(img);
          img = imbinarize(img);
          features(i, :) = extractHOGFeatures(img, 'CellSize', cellSize);
      end
      labels = repmat({trainingSet1(pic).Description}, numImages, 1);
      trainingFeatures =[trainingFeatures; features];
      trainingLabels =[trainingLabels; labels];
end
size(trainingFeatures)
size(trainingLabels)
classifier = fitcknn(trainingFeatures, trainingLabels);
end