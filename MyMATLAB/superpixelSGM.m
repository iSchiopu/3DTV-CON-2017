function [supSGM] = superpixelSGM(image_now, suppix_size)

if length(size(image_now))==2;
    image_now=repmat(image_now,[1 1 3]);
end

[image_now,w]=removeframe(image_now);
[LMean, AMean, BMean, supSGM, boundaries,PixNum, LabelLine,width, height]=SolveSlic(image_now,suppix_size,1);


end
