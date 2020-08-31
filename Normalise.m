function [result] = Normalise(data)
    result = (data-repmat(mean(data), size(data, 1),1))./sqrt(repmat(var(data), size(data, 1),1));
end