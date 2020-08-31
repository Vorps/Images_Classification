function [vec] = Acp(data)
    [vec val] = eig(data'*data) ;%vecteur et valeur propre
    [val,idx] = sort(diag(val),'descend');
    vec = vec(:,idx);
end