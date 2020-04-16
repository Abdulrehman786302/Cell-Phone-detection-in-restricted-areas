function labelIdx =SurfTest_M(testSet1,categoryClassifier,img)
% img=rgb2gray(img);
% img = imbinarize(img);
figure(11)
subplot(221);
imshow(img); hold on;
Features = detectSURFFeatures(img);
plot(Features.selectStrongest(10));
title('SURF Feature for Test')
bag1=bagOfFeatures(testSet1);
featureVector = encode(bag1,img);
% Plot the histogram of visual word occurrences
subplot(222);
bar(featureVector,'r','FaceColor',[0 .5 .5],'EdgeColor',[0 .5 .5],'LineWidth',1.5);
title('Visual word occurrences in testSet');
xlabel('Visual word index');
ylabel('Frequency of occurrence');
[labelIdx,scores] = predict(categoryClassifier,img);
% Display the string label
title(['Predicted label Of Classifier=',categoryClassifier.Labels(labelIdx)]);
end