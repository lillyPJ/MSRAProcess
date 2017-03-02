function box = getRectBoxFromGt(gtFileName)

gtData = importdata(gtFileName);
if isempty(gtData)
    box = [];
    tag = [];
    word = [];
    return;
end

flags = gtData(:, 2); % 0-easy, 1-hard
oriBox = gtData(:, 3:7); % x, y, w, h, theta
ths = gtData(:, 7);
%% only select those easy
oriBox = oriBox(flags < 1, :);
nGt = size(oriBox, 1);
%% process each box(get the poly, from poly to rect)
box = zeros(nGt, 4);
for i = 1:nGt
    polyBox = rectA(oriBox(i,:));
    box(i,:) = fromPolyToRect(polyBox);   
end
end