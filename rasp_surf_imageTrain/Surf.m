function [categoryClassifier]=Surf(processedImage,trainingSet1,testSet1)
Features = detectSURFFeatures(processedImage);
%Display locations of interest in image.
subplot(211);
imshow(processedImage); hold on;
plot(Features.selectStrongest(10));
title('SURF Features');
%convert the ImageDatastore object to an imageSet object.
bag=bagOfFeatures(trainingSet1);
featureVector = encode(bag,trainingSet1);
%Plot the histogram of visual word occurrences
 subplot(212);
 bar(featureVector,'r','FaceColor',[0 .5 .5],'EdgeColor',[0 .5 .5],'LineWidth',1);
 title('Visual word occurrences');
 xlabel('Visual word index');
ylabel('Frequency of occurrence');
categoryClassifier = trainImageCategoryClassifier(trainingSet1, bag);
confMatrix = evaluate(categoryClassifier, trainingSet1);
mean(diag(confMatrix))
confMatrix1 = evaluate(categoryClassifier, testSet1);
mean(diag(confMatrix1))
end