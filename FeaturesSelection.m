function [features, featuresNorm, score, param, idx] = FeaturesSelection(data, group, x,y,z)
    [X,Y, Z] = meshgrid(x, y, z);
    param =  [X(:) Y(:) Z(:)];
    [features, featuresNorm] = GenFeatures(data, param);
    [idx, score] = FisherScore(SplitApply1(featuresNorm(:, :), group)');
end