function [box, tag, word] = loadGTFromTxtFile( gtFile )
% box = [X,Y,W,H];
% tag = {'ab','ac'};
% word(i).box = [x, y, w, h];   word(i).tag = { 'abc' };
fdata = importdata( gtFile );
%fdata = textscan(gtFile,'%s','delimiter','\n');
numWord = size(fdata, 1);
box = zeros( numWord, 4 );
tag = cell( numWord, 1 );
for j = 1:numWord
    fstring = fdata{j};
    fstringCell = regexp( fstring, '"', 'split' );
    fboxCell = regexp( fstringCell{1}, ',', 'split' );
    if  ( length( fboxCell) < 4  )
        fboxCell = regexp( fstringCell{1}, '\s+', 'split' );
    end
    box(j, : ) = [ str2double(fboxCell{1}), str2double(fboxCell{2}) ...
                        str2double(fboxCell{3}), str2double(fboxCell{4}) ];
    tag(j) = fstringCell(2);
end
word = struct( 'box', mat2cell( box, ones( numWord, 1), 4), 'tag', tag);
    