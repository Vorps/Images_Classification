function [result, accurate] = ConfusionMatrice(predictLabel, realLabel)
    result = zeros(max(predictLabel));
    for i = 1:max(predictLabel)
        for j = 1:max(predictLabel)
            result(i,j) = sum ((predictLabel==j).*(realLabel==i));
        end
    end
    accurate = trace(result)/sum(sum(result));
end