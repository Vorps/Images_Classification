function [result, value] = WrapperSelection(train, test)
    value = FindCoupleFeatureCorr(train);
    for i = 1:length(value)
        labelPredict = KNN(train.featuresNorm(:,value(i,:)), train.group, test.featuresNorm(:, value(i,:)), 1);
        [matrix{i}, accurates(i)] = ConfusionMatrice(labelPredict, test.group);
    end
    [acc, idx] = sort(accurates, 'descend')
    for i = 1:length(idx)
        result(i).param = train.param(value(idx(i),:), :)
        result(i).accurate = acc(i)
        result(i).matrix = matrix{idx(i)}
    end
    value = value(idx,:);
end