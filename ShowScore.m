function [] = ShowScore(label, weights, param, mode)
    figure;
    hold on
    stem(1:mode,weights(1:mode), 'r')
    if(mode == 121)
        stem(122:242,weights(122:242), 'g')
        stem(243:362,weights(243:362), 'b')
    end
    plot(find(sum(mod(param(:,1:2), 2) == 0,2) ~= 2), weights(find(sum(mod(param(:,1:2), 2) == 0,2) ~= 2)), '+m')
     if(mode == 121)
        legend('Moments cartésiens', 'Moments centraux', 'Moment centraux-normalisé', 'Paramètres impaires', 'Location','northwest')
    else 
        legend('Moment centraux-normalisé', 'Paramètres impaires', 'Location','northwest')
    end
    xlabel('Caractéristiques')
    ylabel(label)
    hold off
    xticks(1:length(param))
    xtickangle(90)
    xticklabels(arrayfun(@(x,y) [num2str(x)  '|' num2str(y)],param(:,1),param(:,2),'un',0))
    title(['Score des caractéristiques'])
end