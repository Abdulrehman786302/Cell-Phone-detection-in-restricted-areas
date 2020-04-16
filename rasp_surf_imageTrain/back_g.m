function L2 =back_g()
CurrentFrame=imread('Input_1.png');
Background=imread('Inpu_1.png');
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
Out1 = bitxor(CurrentFrame_hsv,Background_hsv);
%Convert RGB 2 GRAY
Out=rgb2gray(Out1);
figure(92)
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
figure(93)
subplot(1,3,1),imshow(BinaryImage),title('BinaryImage');
%Apply Median filter to remove Noise
FilteredImage=medfilt2(BinaryImage,[5 5]);
subplot(1,3,2),imshow(FilteredImage),title('FilteredImage');
%Boundary Label the Filtered Image
[L num]=bwlabel(FilteredImage);
STATS=regionprops(L,'all');
cc=[];
removed=0;
%Remove the noisy regions
for i=1:num
dd=STATS(i).Area;
if (dd < 500)
L(L==i)=0;
removed = removed + 1;
num=num-1;
else
end
end
[L2 num2]=bwlabel(L);
%Trace region boundaries in a binary image.
[B,L,N,A] = bwboundaries(L2);
%Display results

subplot(1,3,3),  imshow(L2);title('BackGround Detected');

end