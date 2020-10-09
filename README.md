# Mobile-phone-detection-
The objective of this work is to detect the cell phone and/or camera used by a person in restricted areas. 
The paper is based on intensive image processing techniques, such as, features extraction and image classification. T
The dataset of images is generated with cell phone camera including positive (with cell phone) and negative (without cell phone) images. 
We then extract relevant features by using classical features extraction techniques including Histogram of Oriented Gradients (HOG) and Speeded up Robust Features (SURF).
The extracted features are then, passed to classifier for detection. We employ Support Vector Machine (SVM), Nearest Neighbor (K-NN) and Decision tree classifier 
which are already trained on our dataset of training images of persons using mobile or otherwise. 
Finally, the detection performance in terms of error rate is compared for various combinations of feature extraction and classification techniques. 
Our results show that SURF with SVM classifier gives the best accuracy.

Different classifier used to predict the results on basis of different features.

Four different folders are attached, in which the m files of different classifer train and then used for predition as well.
HOG with SVM,KNN,Decision Tree, And SURF, with bagOFfeatures.
