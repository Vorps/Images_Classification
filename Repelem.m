function [result] = repelem(data, R)
    result = cell2mat(arrayfun(@(a)repmat(a,R(1), R(2)),data,'uni',false));
end