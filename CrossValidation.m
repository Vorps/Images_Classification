function [matrix, accurates, accurate] = CrossValidation(features, labels, k, knn)
    [~,~,ic] = unique(labels);
    nbclass = max(ic);
    nbPerClass = size(features,1)/nbclass;
    M = ones(k, nbPerClass);
    M(:, 1:floor(nbPerClass/k)*k) = Repelem(eye(k,k), [1, floor(nbPerClass/k)])+1;
    M = repmat(M,1,nbclass);
    featuresCross = SplitApply(features, M);
    labelCross = SplitApply(labels, M);
    for i = 1:length(featuresCross)
        labelPredict = KNN(featuresCross{i,1}, labelCross{i,1},featuresCross{i,2},knn);
        [matrix{i}, accurates(i)] = ConfusionMatrice(labelPredict, labelCross{i,2});
    end
    accurate = mean(accurates);
end