% saveFigDemo

CASE = 'test';
destFigDir = 'figure';
mkdir(fullfile(destFigDir, CASE));
imgFiles = dir(fullfile(CASE, '*.JPG'));
nImg = numel(imgFiles);
for i = 1:nImg
    % read and show image
    imgBaseName = imgFiles(i).name;
    imageName = fullfile(CASE, imgBaseName);
    image = imread(imageName);
    cla;
    imshow(image);
    % read and show gt
    gtName = fullfile(CASE, [imgBaseName(1:end-3), 'gt']);
    gtData = importdata(gtName);
    if ~isempty(gtData);
        flags = gtData(:, 2); % 0-easy, 1-hard
        goodBoxes = gtData(flags < 1, 3:7); % x, y, w, h, theta
        badBoxes = gtData(flags > 0, 3:7);
        
    else
        goodBoxes = [];
        badBoxes = [];
    end
    displayPoly(goodBoxes, 'g');
    displayPoly(badBoxes, 'r');  
    saveas(gcf, fullfile(destFigDir,  CASE, [imgBaseName(1:end-3), 'jpg']));
    fprintf('%d:%s\n', i, imgBaseName);
end