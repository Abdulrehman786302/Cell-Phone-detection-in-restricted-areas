function label=hogtest1(img,classifier)
% Extract HOG features and HOG visualization
[hog_4x4, vis4x4] = extractHOGFeatures(img,'CellSize',[4 4]);
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
Features1=extractHOGFeatures(img,'CellSize',[8 8]);
figure(12)
subplot(221); 
imshow(img);
title('Img for test Classifier')
label=predict(classifier, Features1)
subplot(222);
plot(vis8x8); 
% Make class predictions using the test features.
title({'CellSize = [8 8]' ; ['Length = ' num2str(length(hog_8x8))]});
end