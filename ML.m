clear;clc; close all;
addpath('./libsvm-3.24/matlab/')
%%
Data_train_init = load('Save/Data_train_init');
Data_train_rotate_360 = load('Save/Data_train_rotate_360');
Data_train_rotate_90 = load('Save/Data_train_rotate_90');
Data_analyse_error = load('Save/Data_analyse_error');
Data_test = load('Save/Data_test');
Data_databases_test = load('Save/Data_databases_test');
%%
train = Data_train_rotate_90;
test = Data_databases_test;
%% Recherche du couple de caractéristque
[cFeatures, value] = WrapperSelection(train, test);
%% 5 meilleures performances wrapper
for i = 1:5
    figure;
    heatmap(cFeatures(i).matrix);
    title(['Matrice de confusion, Features couple : n_{',num2str(cFeatures(i).param(1,1)), ',',num2str(cFeatures(i).param(1,2)),'}','n_{',num2str(cFeatures(i).param(2,1)), ',',num2str(cFeatures(i).param(2,2)),'} : Résultat ', num2str(cFeatures(i).accurate)])
    xlabel('Classe prédite')
    ylabel('Classe reel')
    figure;
    hold on
    plot(train.featuresNorm(train.group == 1, value(i,1)), train.featuresNorm(train.group == 1, value(i,2)), '.r')
    plot(train.featuresNorm(train.group == 2, value(i,1)), train.featuresNorm(train.group == 2, value(i,2)), '.g')
    plot(train.featuresNorm(train.group == 3, value(i,1)), train.featuresNorm(train.group == 3, value(i,2)), '.b')
    plot(train.featuresNorm(train.group == 4, value(i,1)), train.featuresNorm(train.group == 4, value(i,2)), '.m')
    legend('Clubs', 'Diamonds', 'Hearts', 'Spades')
    xlabel(['n_{',num2str(cFeatures(i).param(1,1)), ',',num2str(cFeatures(i).param(1,2)),'}'])
    ylabel(['n_{',num2str(cFeatures(i).param(2,1)), ',',num2str(cFeatures(i).param(2,2)),'}'])
    title(['n_{',num2str(cFeatures(i).param(2,1)), ',',num2str(cFeatures(i).param(2,2)),'} en fonction de n_{',num2str(cFeatures(i).param(1,1)), ',',num2str(cFeatures(i).param(1,2)),'} et de la classe'])
    hold off
end
%%
value = [1,20];
figure;
hold on
plot(test.featuresNorm(test.group == 1, value(1)), test.featuresNorm(test.group == 1, value(2)), '.r')
plot(test.featuresNorm(test.group == 2, value(1)), test.featuresNorm(test.group == 2, value(2)), '.g')
plot(test.featuresNorm(test.group == 3, value(1)), test.featuresNorm(test.group == 3, value(2)), '.b')
plot(test.featuresNorm(test.group == 4, value(1)), test.featuresNorm(test.group == 4, value(2)), '.m')
plot(train.featuresNorm(train.group == 1, value(1)), train.featuresNorm(train.group == 1, value(2)), '-r')
plot(train.featuresNorm(train.group == 2, value(1)), train.featuresNorm(train.group == 2, value(2)), '-g')
plot(train.featuresNorm(train.group == 3, value(1)), train.featuresNorm(train.group == 3, value(2)), '-b')
plot(train.featuresNorm(train.group == 4, value(1)), train.featuresNorm(train.group == 4, value(2)), '-m')
legend('Clubs test', 'Diamonds test', 'Hearts test', 'Spades test', 'Clubs train', 'Diamonds train', 'Hearts train', 'Spades train')
title('n_{2,0} en fonction de n_{0,2} et de la classe')
xlabel('n_{2,0}')
ylabel('n_{0,2}')
hold off

%% KNN model
labelPredict = KNN(train.featuresNorm(:,value(1,:)), train.group, test.featuresNorm(:, value(1,:)), 1);
[matrix, accurates] = ConfusionMatrice(labelPredict, test.group);
heatmap(matrix);
title(['Matrice de confusion KNN: ', num2str(accurates),  ' n_{2,0} et n_{0,2}'])
xlabel('Classe prédite')
ylabel('Classe reel')
%% SVM Model
model = svmtrain(train.group, [train.featuresNorm(:, 1),train.featuresNorm(:, 20)]);
predicted_label = svmpredict(test.group, [test.featuresNorm(:, 1), test.featuresNorm(:, 20)], model);
[matrix, accurates] = ConfusionMatrice(predicted_label, test.group);
heatmap(matrix);
title(['Matrice de confusion SVM: ', num2str(accurates),  ' n_{2,0} et n_{0,2}'])
xlabel('Classe prédite')
ylabel('Classe reel')
%% ACP
pca = Acp(train.featuresNorm);
dataPca = train.featuresNorm*pca;
figure;
hold on
plot(dataPca(train.group == 1, 1), dataPca(train.group == 1, 2),'.r')
plot(dataPca(train.group == 2, 1), dataPca(train.group == 2, 2), '.g')
plot(dataPca(train.group == 3, 1), dataPca(train.group == 3, 2), '.b')
plot(dataPca(train.group == 4, 1), dataPca(train.group == 4, 2), '.m')
legend('Clubs', 'Diamonds', 'Hearts', 'Spades')
xlabel('f_1')
ylabel('f_2')
title('f_1 en fonction de f_2 et de la classe')
hold off
figure;
hold on
plot(dataPca(train.group == 1, 2),'.r')
plot(dataPca(train.group == 2, 2), '.g')
plot(dataPca(train.group == 3, 2), '.b')
plot(dataPca(train.group == 4, 2), '.m')
legend('Clubs', 'Diamonds', 'Hearts', 'Spades')
xlabel('Rotation images [0 90]')
ylabel('f_2')
title('f_1 en fonction de la rotation des images [0 90] et de la classe')
hold off
%% SVM APC
model = svmtrain(train.group, train.featuresNorm(:, 1)+train.featuresNorm(:, 20));
predicted_label = svmpredict(test.group, test.featuresNorm(:, 1)+ test.featuresNorm(:, 20), model);
[matrix, accurates] = ConfusionMatrice(predicted_label, test.group);
heatmap(matrix);
title(['Matrice de confusion SVM ACP: ', num2str(accurates)])
xlabel('Classe prédite')
ylabel('Classe reel')

%% MAP 
U1 = Data_analyse_error.featuresNorm(Data_analyse_error.group == 1, 1)+Data_analyse_error.featuresNorm(Data_analyse_error.group == 1, 20);
U2 = Data_analyse_error.featuresNorm(Data_analyse_error.group == 2, 1)+Data_analyse_error.featuresNorm(Data_analyse_error.group == 2, 20);
U3 = Data_analyse_error.featuresNorm(Data_analyse_error.group == 3, 1)+Data_analyse_error.featuresNorm(Data_analyse_error.group == 3, 20);
U4 = Data_analyse_error.featuresNorm(Data_analyse_error.group == 4, 1)+Data_analyse_error.featuresNorm(Data_analyse_error.group == 4, 20);
[thresh1, matrix1]  = MAP(U4, U2);
[thresh2, matrix2]  = MAP(U2, U1);
[thresh3, matrix3]  = MAP(U1, U3);
accurate = 1-(sum(matrix1(2,:))+sum(matrix2(2,:))+sum(matrix3(2,:)))/length(Data_analyse_error.group)
figure;
hold on
histogram(U1, 'EdgeColor', 'r');
histogram(U2, 'EdgeColor', 'g');
histogram(U3, 'EdgeColor', 'b');
histogram(U4, 'EdgeColor', 'm');
xline(thresh1, 'Color', 'r', 'LineWidth',0.5)
xline(thresh2, 'Color', 'r', 'LineWidth',0.5)
xline(thresh3, 'Color', 'r', 'LineWidth',0.5)
xline(mean(U4)+(mean(U2)-mean(U4))/2, 'Color', 'g')
xline(mean(U2)+(mean(U1)-mean(U2))/2, 'Color', 'g')
xline(mean(U1)+(mean(U3)-mean(U1))/2, 'Color', 'g')
title(['Distribution des caractéristiques en fonction des classes'])
legend('Clubs', 'Diamonds', 'Hearts', 'Spades', 'Seuil MAP', 'Seuil SVM')
hold off
%% Map model
label = MAPClassifieur([U4, U2, U1, U3],  [test.featuresNorm(:, 1)+test.featuresNorm(:, 20)]);
group = [4,2,1,3]
labelPredict = group(label)';

figure;
[matrix, accurates] = ConfusionMatrice(labelPredict, test.group);
heatmap(matrix);
title(['Matrice de confusion MAP : ', num2str(accurates)])
xlabel('Classe prédite')
ylabel('Classe reel')
%%
k = 5;
[matrix, accurates, accurate] = CrossValidation(train.featuresNorm(:,[2, 22]), train.group, k, 1);
%%
figure;
for i = 1:k
    subplot(k,1,i)  
    heatmap(matrix{i});
    title(['Matrice de confusion : ', num2str(accurates(i))])
    xlabel('Classe prédite')
    ylabel('Classe reel')
end
%%
OptimiseHyperParam(train.featuresNorm, train.group, 1:2,1:2)

