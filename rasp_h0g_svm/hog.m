function [classifier,hogFeatureSize,cellSize]=hog(img,trainingSet1) 
% Extract HOG features and HOG visualization
[hog_4x4,vis4x4] = extractHOGFeatures(img,'CellSize',[4 4]);
[hog_8x8,vis8x8] = extractHOGFeatures(img,'CellSize',[8 8]);
[hog_16x16,vis16x16] = extractHOGFeatures(img,'CellSize',[16 16]);
% Show the original image 
subplot(2,3,1:3); imshow(img);
title('Sample for training');
% Visualize the HOG features
subplot(2,3,4);  
plot(vis4x4); 
title({'CellSize = [4 4]'; ['Length = ' num2str(length(hog_4x4))]});
subplot(2,3,5);
plot(vis8x8); 
title({'CellSize = [8 8]'; ['Length = ' num2str(length(hog_8x8))]});
subplot(2,3,6);
plot(vis16x16); 
title({'CellSize = [16 16]'; ['Length = ' num2str(length(hog_16x16))]});
%identify the optimal parameter settings.
cellSize = [8 8];
hogFeatureSize = length(hog_8x8);
figure(10)
subplot(211)
imshow(img);
title('Sample for training');
subplot(212);
plot(vis8x8); 
title({'CellSize = [8 8]'; ['Length = ' num2str(length(hog_8x8))]; 'Best Cell size'});
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
          %img=Pre_pro(img);
          features(i, :) = extractHOGFeatures(img, 'CellSize', cellSize);
      end
      labels = repmat({trainingSet1(pic).Description}, numImages, 1);
      trainingFeatures =[trainingFeatures; features];
      trainingLabels =[trainingLabels; labels];
end
classifier = fitcecoc(trainingFeatures, trainingLabels);
end