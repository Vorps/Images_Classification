function [accurate] = OptimiseHyperParam(features, labels, ns, knns)
    x = 1;
    accurate = zeros(length(ns),length(knns));
    for n = ns
        y = 1;
        for k = knns
            [~, ~, accurate(x,y)] = CrossValidation(features(:,1:n), labels(:,1), 3, k);
            y = y +1;
        end
        x = x +1;
    end
end