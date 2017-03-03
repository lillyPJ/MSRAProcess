% testMinBoundingBox
clear all;
clc;
cla;
txtBase = '/home/lili/datasets/shopSign/gt/test/txt';
imgBase = '/home/lili/datasets/shopSign/img/test';
imgID = 'xm_0220';
% %imgID = 'xm_0388';
% imgID = 'xm_0256';
% imgID = 'xm_0487';
gtFile = fullfile(txtBase, [imgID, '.txt']);
imgFile = fullfile(imgBase, [imgID, '.jpg']);
gtPoints  = loadGTFromTxtFile(gtFile);
gtPointsBox = gtPoints;
gtP = reshape(gtPoints', [2, size(gtPoints, 1)*2]);
img = imread(imgFile);
imshow(img);
%displayBox(gtPointsBox, 'm');
hold on;
%plot(gtP(1,:), gtP(2,:), 'bo');
poly = minBoundingBox(gtP);
displayEightBox(poly,'g');  

[angleBox, anglePoly] = getAngleBox(poly);
 
 fprintf('theta = %f\n', angleBox(5)); 
 %bb = rectA(box, 0.680267);
displayEightBox(anglePoly, 'm');
displayBox(angleBox, 'b');
displayPoly(angleBox, 'y');
axis equal;
