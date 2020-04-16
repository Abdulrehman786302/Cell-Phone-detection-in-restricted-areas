function [trainingSet1, testSet1 ,img] = dataset3()
imgFolder=fullfile('F:','FYP Project','Matlab & Raspberry pi 2','Data');
imgSet = imageSet(imgFolder, 'recursive');
{imgSet.Description} % display all labels on one line
[imgSet.Count];         % show the corresponding count of images
minSetCount = min([imgSet.Count]); % determine the smallest amount of images in a category
%Use partition method to trim the set.
imgSet= partition(imgSet, minSetCount, 'randomize');
%Notice that each set now has exactly the same number of images.
[imgSet.Count];
categories={'mobile','nomobile'};
imgs=fullfile(imgFolder, categories);
imds = imageDatastore(imgs, 'LabelSource', 'foldernames');
allimg=countEachLabel(imds);
%Because imds above contains an unequal number of images per category, let's first adjust it, 
% so that the number of images in the training set is balanced.
minSetCount = min(allimg{:,2}); % determine the smallest amount of images in a category
% Use splitEachLabel method to trim the set.
imds = splitEachLabel(imds, minSetCount, 'randomize');
% Notice that each set now has exactly the same number of images.
countEachLabel(imds);
% Find the first instance of an image for each category
mobile = find(imds.Labels == 'mobile',1);
nomobile = find(imds.Labels == 'nomobile',1);
figure (1)
subplot(1,2,1);
imshow(readimage(imds,mobile));
title('Pic sample with Mobile');
subplot(1,2,2);
imshow(readimage(imds,nomobile));
title('Img sample no Mobile');
%divede data set into training and test 
%Create two new datastores from the files in imds. 
%The first datastore imds60 contains the first 30% of files with the demos label and the first 30% of files with the imagesci label. 
%The second datastore imds40 contains the remaining 40% of files from each label. 
%If the percentage applied to a label does not result in a whole number of files, splitEachLabel rounds down to the nearest whole number.
[trainingSet, testSet] = splitEachLabel(imds, 0.3, 'randomize');
% figure(2)
%Separate the two sets into training and test data. Pick 40% of images from each set 
%for the training data and the remainder 60% for the test data
[trainingSet1, testSet1] = partition(imgSet, 0.3, 'randomize');
exTestImage = readimage(trainingSet,40);
processedImage1=rgb2gray(exTestImage);
img = imbinarize(processedImage1);
end