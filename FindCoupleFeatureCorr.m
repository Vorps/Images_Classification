function [value] = FindCoupleFeatureCorr(data)
    correlation = corr(data.featuresNorm(:, :), data.featuresNorm(:, :));
    [~, I] = min(correlation(:,:));
    [Lia,Locb] = ismember([1:118;I]',[I;1:118]', 'rows');
    value = [1:118; I]';
    tmp1 = Locb(Lia);
    tmp2 = find(Lia);
    clear result1
    u = 1;
    for i = 1:sum(Lia)
        if(tmp1(i) > tmp2(i))
            result(1, u) = tmp1(i);
            u = u+1;
        end
    end
    value(result, :) = [];
end