% testShowDemo
imgDir = './img/train';

imgFiles = dir(fullfile(imgDir, '*.JPG'));
nImg = numel(imgFiles);
for i = 1:nImg
    imgBaseName = imgFiles(i).name;
    %imgBaseName = 'IMG_1805.JPG';
    imageName = fullfile(imgDir, imgBaseName);
    image = imread(imageName);
    gtName = fullfile(imgDir, [imgBaseName(1:end-3), 'gt']);
    gtData = importdata(gtName);
    if ~isempty(gtData)
        ids = gtData(:, 1); % 0-n
        flags = gtData(:, 2); % 0-easy, 1-hard
        boxes = gtData(:, 3:7); % x, y, w, h, theta
        ths = gtData(:, 7);
    else
        boxes = [];
    end
    cla;
    clf;
    imshow(image);
    %displayPoly(boxes);
    displayBox(boxes,'b');
    % -------test our rectA and getAngleBox function ------
%     nBox = size(boxes, 1);
%     for j = 1:nBox
%         tempPoly = rectA(boxes(j,1:4), boxes(j,5));
%         [angleBox, anglePoly] = getAngleBox(tempPoly);
%         displayBox(angleBox, 'r');
%     end
%     fprintf('%d:%s\n', i, imgBaseName);
%     if ~isempty(boxes)
%         fprintf('theta = %f\n', boxes(:,5));
%     end
end