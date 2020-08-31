function [data, labels] = OpenData(path)
    S = dir([path, '/*.png']); 
    for k = 1:numel(S)
        data(:,:, k) = imread(fullfile(path,S(k).name));
        labels(k, :) = strsplit(regexprep(S(k).name, '.png', ''), '_');
    end
end