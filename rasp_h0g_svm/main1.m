clc;
clear all;
close all;
tic;
figure(1);
[mypi]=raspbeery_PI();
figure(2);
raspbeery_PI_1(mypi);
img1=back_g();
figure(6);
im=Pre_pro(img1);
[trainingSet1, testSet1,img]=dataset3();
%figure(8)
%im1=Pre_pro(img);
figure(9);
[classifier,hogFeatureSize,cellSize]=hog(img,trainingSet1);
figure(11)
im=imresize(im,[100 100])
labels=hogtest1(im,classifier);
%writeLED(mypi,'led0',false)
is=strcmp(labels,'Mobile')
if(is==1)
 writeLED(mypi,'led0',1);
figure(13)
text(0.3,0.5,'Mobile','Color','red','FontSize',36);
else
writeLED(mypi,'led0',false)
figure(14)
text(0.3,0.5,'No Mobile','Color','red','FontSize',36);
end
toc