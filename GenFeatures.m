function [features, featuresNorm] = GenFeatures(data, param)
    n = size(data,3);
    for i = 1:n
        e = 1;
        for p = param'
            % Calcule des moments d'ordre p,q + type
            features(i, e)=  Moment(data(:,:,i), p);
            e = e +1;
        end
        disp(['Progression :  ', sprintf('%.2f',i/n*100) ' %']);
    end
    % Z-Score
    featuresNorm = Normalise(features); % Normalisation des features
    featuresNorm = reshape(featuresNorm(~isnan(featuresNorm(:)))...
    , size(featuresNorm,1), []);
end