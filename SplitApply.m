function [result] = SplitApply(data, group)
    for x = 1:size(group, 1)
        for y = 1:max(max(group))
             result{x, y} = data(group(x) == y, :)
        end
    end
end