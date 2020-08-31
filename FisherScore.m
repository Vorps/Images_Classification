function [idx, score] = FisherScore(trainfeatures)
    mu_c = cellfun(@mean,trainfeatures,'Uniform',false);
    var_c = cellfun(@var,trainfeatures,'Uniform',false);
    inter_class = sum(cell2mat(cellfun(@(x) x.^2, mu_c , 'UniformOutput',false)));
    intra_class = sum(cell2mat(var_c));
    score = inter_class./ intra_class;
    [~,idx] = sort(score, 'descend');
end