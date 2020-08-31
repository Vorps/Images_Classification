clear;clc; close all;
%%
Data_train_init = load('Save/Data_train_init');
Data_train_rotate_360 = load('Save/Data_train_rotate_360');
Data_train_rotate_90 = load('Save/Data_train_rotate_90');
Data_database_test = load('Save/Data_databases_test');
%% Algorithme de sélection
data = Data_database_test;
[idx, score] = FisherScore(SplitApply1(data.featuresNorm(:, :), data.group)');
ShowScore('Fisher Score', score, data.param, 118)

figure;
hold on
legend('on')
plot(data.featuresNorm(data.group == 1, idx(1:3)), 'r','DisplayName','Clubs')
plot(data.featuresNorm(data.group == 2, idx(1:3)), 'g','DisplayName','Diamonds')
plot(data.featuresNorm(data.group == 3, idx(1:3)), 'b','DisplayName','Hearts')
plot(data.featuresNorm(data.group == 4, idx(1:3)), 'm','DisplayName','Spades')
xlabel('Rotation en degrée')
ylabel('Moment n_{5,5}')
title('3 meilleures caractéristiques en fonction de la rotation des images et par classe')
hold off

correlation = corr(data.featuresNorm(:, idx(1:3)), data.featuresNorm(:, idx(1:3)));
figure;
heatmap(correlation);
title('Corrélation des 3 meilleures caractéristiques')
%% Recherche de régularité dans l’espace de représentation pour la rotation des images
data = Data_database_test;
figure;
hold on
legend('on')
plot(data.featuresNorm(data.group == 1, end), 'r','DisplayName','Clubs')
plot(data.featuresNorm(data.group == 2, end), 'g','DisplayName','Diamonds')
plot(data.featuresNorm(data.group == 3, end), 'b','DisplayName','Hearts')
plot(data.featuresNorm(data.group == 4, end), 'm','DisplayName','Spades')
xlabel('Rotation en degrée')
ylabel('Moment n_{5,5}')
title('Meilleure caractéristique de la rotation des images et par classe')
hold off
%% Recherche du sous-ensemble de caractéristique optimale
data = Data_database_test;
[idx, score] = FisherScore(SplitApply1(data.featuresNorm(:, :), data.group)');
ShowScore('Fisher Score', score, data.param, 118)
figure;
hold on
legend('on')
plot(data.featuresNorm(data.group == 1, idx(1:3)), 'r','DisplayName','Clubs')
plot(data.featuresNorm(data.group == 2, idx(1:3)), 'g','DisplayName','Diamonds')
plot(data.featuresNorm(data.group == 3, idx(1:3)), 'b','DisplayName','Hearts')
plot(data.featuresNorm(data.group == 4, idx(1:3)), 'm','DisplayName','Spades')
xlabel('Rotation en degrée')
ylabel('Moment n_{5,5}')
title('3 meilleures caractéristiques en fonction de la rotation des images [0 90] et par classe')
hold off
