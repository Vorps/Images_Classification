%Deprecated for fisher score
function [select] = MeasureFeatures(trainfeatures)
    mini = cellfun(@min,trainfeatures, 'UniformOutput',false);
    maxi = cellfun(@max,trainfeatures, 'UniformOutput',false);
    E = repelem((1:4),4, 1)';
    I = E(eye(4)'~=1);
    miniTest = arrayfun(@(x) mini(x), I);
    maxiTest = arrayfun(@(x) maxi(x), I);
    trainfeaturesTest = repelem(trainfeatures,2);
    test = cellfun(@(x, y, z) sum(x >= y & x <= z),trainfeaturesTest, miniTest, maxiTest, 'UniformOutput',false);
    select = cellfun(@minimal, test, 'UniformOutput', false);
end


function [idx] = minimal(x)
    [value,idx] = sort(x);
end