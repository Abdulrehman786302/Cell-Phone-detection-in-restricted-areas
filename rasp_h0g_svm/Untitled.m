clc,clear all,close all;
A = imread('Input_1.png');
A = imresize(A,0.25);
Agray = rgb2gray(A);
figure
imshow(A);
imageSize = size(A);
numRows = imageSize(1);
numCols = imageSize(2);
wavelengthMin = 4/sqrt(2);
wavelengthMax = hypot(numRows,numCols);
n = floor(log2(wavelengthMax/wavelengthMin));
wavelength = 2.^(0:(n-2)) * wavelengthMin;
deltaTheta = 45;
orientation = 0:deltaTheta:(180-deltaTheta);
g = gabor(wavelength,orientation);
gabormag = imgaborfilt(Agray,g);

for i = 1:length(g)
    sigma = 0.5*g(i).Wavelength;
    K = 3;
    gabormag(:,:,i) = imgaussfilt(gabormag(:,:,i),K*sigma); 
end
%When constructing Gabor feature sets for classification, it is useful to add a map of spatial location information in both X and Y. 
%This additional information allows the classifier to prefer groupings which are close together spatially.
X = 1:numCols;
Y = 1:numRows;
[X,Y] = meshgrid(X,Y);
featureSet = cat(3,gabormag,X);
featureSet = cat(3,featureSet,Y);
numPoints = numRows*numCols;
X = reshape(featureSet,numRows*numCols,[]);
%%Normalize the features to be zero mean, unit variance.
X = bsxfun(@minus, X, mean(X));
X = bsxfun(@rdivide,X,std(X));
%%Visualize the feature set.
%To get a sense of what the Gabor magnitude features look like, 
%Principal Component Analysis can be used to move from a 26-D representation of each pixel in the input image 
%into a 1-D intensity value for each pixel.
coeff = pca(X);
feature2DImage = reshape(X*coeff(:,1),numRows,numCols);
figure
imshow(feature2DImage,[])
L = kmeans(X,2,'Replicates',5);
%Visualize segmentation using label2rgb.
L = reshape(L,[numRows numCols]);
figure
imshow(label2rgb(L))