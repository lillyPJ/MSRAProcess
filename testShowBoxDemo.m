% testShowBoxDemo: normal rect box
imgDir = './img/train';

imgFiles = dir(fullfile(imgDir, '*.JPG'));
nImg = numel(imgFiles);
for i = 1:nImg
%     if i < 6
%         continue;
%     end
    imgBaseName = imgFiles(i).name; 
    imgBaseName = 'IMG_1805.JPG';
    imageName = fullfile(imgDir, imgBaseName);
    image = imread(imageName);
    gtFileName = fullfile(imgDir, [imgBaseName(1:end-3), 'gt']);
    box = getRectBoxFromGt(gtFileName);
    [imgH, imgW, D] = size(image);
    newBox = checkBoxBound(box, imgW, imgH);
    imshow(image);
    displayBox(newBox);
    fprintf('%d:%s\n', i, imgBaseName);
end