clc;
clear all;
close all;
% %figure(1);
% [mypi]=raspbeery_PI();
% figure(20);
% raspbeery_PI_1(mypi);
img1=back_g();
[trainingSet1, testSet1,img]=dataset3();
figure(5)
[classifier,hogFeatureSize,cellSize]=hog(img,trainingSet1);
figure(7)
labels=hogtest1(img1,classifier);
% writeLED(mypi,'led0',false)
is=strcmp(labels,'Mobile')
if(is==1)
% writeLED(mypi,'led0',1);
figure(12)
text(0.3,0.5,'Mobile','Color','red','FontSize',36);
else
% writeLED(mypi,'led0',false)
figure(13)
text(0.3,0.5,'No Mobile','Color','red','FontSize',36);
end