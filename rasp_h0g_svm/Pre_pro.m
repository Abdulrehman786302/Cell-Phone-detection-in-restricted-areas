function [biggest]=Pre_pro(BW)
subplot(231)
imshow(BW);
title('input image');
BW2 = imfill(BW);
subplot(232)
imshow(BW2);
title('Holes filling');
holes = BW2 & ~BW;
subplot(233)
imshow(holes)
title('Hole pixels identified')
bigholes = bwareaopen(holes, 200);
subplot(234)
imshow(bigholes)
title('Only the big holes')
CC = bwconncomp(BW2);
    numOfPixels = cellfun(@numel,CC.PixelIdxList);
       [unused,indexOfMax] = max(numOfPixels);
           biggest = zeros(size(BW2));
                biggest(CC.PixelIdxList{indexOfMax}) = 1;
                subplot(235)
                imshow(biggest);
                title('Biggest Componets')
                end

                  