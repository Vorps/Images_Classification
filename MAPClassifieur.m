function [label] = MAPClassifieur(trainFeature, testFeature)
    for i = 1:size(trainFeature, 2)-1
         thresh(i) = MAP(trainFeature(:, i), trainFeature(:, i+1));
    end
    label = sum(thresh < testFeature, 2)+1;
end