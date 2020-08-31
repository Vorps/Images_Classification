function [result] = SplitApply1(data, group)
    for x = 1:max(max(group))
         result{x} = data(group(:, 1) == x, :)
    end
end