% changeToNomalDatasetDemo

sourceImgBase = '/home/lili/datasets/MSRATD500/raw/img';
subDirs = {'train', 'test'};
destBase = '/home/lili/datasets/MSRATD500';
nSub = length(subDirs);

for i = 1:nSub
    sourceImgDir = fullfile(sourceImgBase, subDirs{i});
    sourceGtDir = sourceImgDir;
    destImgDir = fullfile(destBase, 'img', subDirs{i});
    destGtDir = fullfile(destBase, 'gt', subDirs{i}, 'txt');
    imgFiles = dir(fullfile(sourceImgDir, '*.JPG'));
    nImg = numel(imgFiles);
    % make new dir
    mkdir(destImgDir);
    mkdir(destGtDir);
    for j = 1:nImg
        imgBase = imgFiles(j).name;
        fprintf('%s:%d:%s\n', subDirs{i}, j, imgBase);
        sourceImgName = fullfile(sourceImgDir, imgBase);
        destImgName= fullfile(destImgDir, [imgBase(1:end-3), 'jpg']);
        sourceGtName = fullfile(sourceImgDir, [imgBase(1:end-3), 'gt']);
        destGtName = fullfile(destGtDir, [imgBase(1:end-3), 'txt']);
        % copy image files
        copyfile(sourceImgName, destImgName);
        % generate gt files
        box = getRectBoxFromGt(sourceGtName);
        fp = fopen(destGtName, 'wt');
        nBox = size(box, 1);
        image = imread(sourceImgName);
        [imgH, imgW, D] = size(image);
        box = checkBoxBound(box, imgW, imgH);
        box = floor(box);
        if nBox > 0
            box(:,3) = box(:,3) + box(:,1);
            box(:,4) = box(:,4) + box(:,2);
        end
        for k = 1:nBox
            fprintf(fp, '%d, %d, %d, %d, "#"\n', box(k,:));
        end
        fclose(fp);
        
    end
    
end