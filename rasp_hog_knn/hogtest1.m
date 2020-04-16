function label=hogtest1(img,classifier)
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
Features1=extractHOGFeatures(img,'CellSize',[32 32]);
figure(8)
subplot(221); 
imshow(img);
title('Img for test Classifier')
label=predict(classifier, Features1)
subplot(222);
plot(vis32x32); 
% Make class predictions using the test features.
title({'CellSize = [32 32]' ; ['Length = ' num2str(length(hog_32x32))]});
end