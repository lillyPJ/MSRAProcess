% testShowMinBoundDemo
imgDir = './img/train';

imgFiles = dir(fullfile(imgDir, '*.JPG'));
nImg = numel(imgFiles);
for i = 1:nImg
    imgBaseName = imgFiles(i).name; 
    imageName = fullfile(imgDir, imgBaseName);
    image = imread(imageName);
    gtName = fullfile(imgDir, [imgBaseName(1:end-3), 'gt']);
    gtData = importdata(gtName);
    ids = gtData(:, 1); % 0-n
    flags = gtData(:, 2); % 0-easy, 1-hard
    boxes = gtData(:, 3:7); % x, y, w, h, theta
    ths = gtData(:, 7);
    imshow(image);
    displayPoly(boxes);

end