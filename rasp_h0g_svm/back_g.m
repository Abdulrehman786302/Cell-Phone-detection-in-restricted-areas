function L2 =back_g()
figure(3)
CurrentFrame=imread('Int_1.png');
Background=imread('pu_1.png');
size(CurrentFrame)
size(Background)
%Display Background and Foreground
subplot(2,1,1);imshow(Background);title('BackGround');
subplot(2,1,2);imshow(CurrentFrame);title('Current Frame');
%Convert RGB 2 HSV Color conversion
[Background_hsv]=round(rgb2hsv(Background));
[CurrentFrame_hsv]=round(rgb2hsv(CurrentFrame));
size(CurrentFrame_hsv)
size(Background_hsv)
%bitxor Operation (Bit wise XOR Operation)
Out1 = bitxor(Background_hsv,CurrentFrame_hsv);
%Convert RGB 2 GRAY
Out=rgb2gray(Out1);
figure(4)
subplot(2,1,1);imshow(Out1);title('Xor operation');
subplot(2,1,2);imshow(Out);title('grayscale');
%Read Rows and Columns of the Image
[rows columns]=size(Out);
%Convert to Binary Image
for i=1:rows
for j=1:columns

if Out(i,j) >0
BinaryImage(i,j)=1;
else
BinaryImage(i,j)=0;
end
end
end
figure(5)
subplot(1,3,1),imshow(BinaryImage),title('BinaryImage');
%Apply Median filter to remove Noise
FilteredImage=medfilt2(BinaryImage,[5 5]);
subplot(1,3,2),imshow(FilteredImage),title('FilteredImage');
%Boundary Label the Filtered Image
[L2 num]=bwlabel(FilteredImage);
end