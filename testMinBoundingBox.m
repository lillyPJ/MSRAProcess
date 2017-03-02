% testMinBoundingBox
clear all;
clc;
cla;
txtBase = '/home/lili/datasets/shopSign/gt/test/txt';
imgBase = '/home/lili/datasets/shopSign/img/test';
imgID = 'xm_0220';
gtFile = fullfile(txtBase, [imgID, '.txt']);
imgFile = fullfile(imgBase, [imgID, '.jpg']);
gtPoints  = loadGTFromTxtFile(gtFile);
gtPointsBox = gtPoints;
gtP = reshape(gtPoints', [2, size(gtPoints, 1)*2]);
img = imread(imgFile);
imshow(img);
%displayBox(gtPointsBox, 'm');
hold on;
plot(gtP(1,:), gtP(2,:), 'bo');
box = minBoundingBox(gtP);
displayEightBox(box,'r');  
tanValue = (box(2,2)-box(2,1))/(box(1,2)-box(1,1));
if tanValue > pi/2
    tanValue = 1/tanValue;
end
theta = atan(tanValue);
bb = rectA(box, theta);
%bb = rectA(box, 0.680267);
displayEightBox(bb, 'g');
axis equal;
