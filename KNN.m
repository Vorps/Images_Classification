function [idx] = KNN(trainFeatures,trainLabels,testFeatures,k)
    [C,~,Y] = unique(trainLabels,'stable');
    [~,I] = sort(reshape(sqrt(sum((Repelem(testFeatures,[size(trainFeatures,1),1])-repmat(trainFeatures, [size(testFeatures,1), 1])).^2,2)),size(trainFeatures, 1), size(testFeatures, 1)));
    if k ~= 1
         [~, idx] = max(histc(Y(I(1:k, :)), 1:length(C)));
    else 
        idx = Y(I(1:k, :));
    end
end