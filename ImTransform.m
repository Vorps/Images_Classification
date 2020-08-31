function [result, dim] = ImTransform(image, R)
    [m,n] = size(image);
    [X,Y] = meshgrid(1:m,1:n);
    % Matrice de position des pixels
    param =  [X(:) Y(:) ones(size(Y(:),1), 1)];
    % Application de la matice de transformation
    source = uint8((param-[m/2 n/2 0])*R'+[m/2 n/2 0]);
    % Les index qui dépasse les dimensions son mis à 1
    source(~(all(source(:,1:2) >= 1, 2) & all(source(:,1:2) <= [m n], 2)), :) = 1;
    % Génération de la nouvelle image avec les indice modifié
    result(sub2ind(size(image), X(:), Y(:))) = ...
    image(sub2ind(size(image), source(:,1), source(:,2)));
    result = reshape(result, m, n);
    % Dimension de l'objet pour les positions
    [~, col1] = find(result);
    [~, col2] = find(result');
    dim = [min(col1) min(col2) max(col1) max(col2) n-max(col1) m-max(col2)];
end