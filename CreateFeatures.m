clear;clc; close all;
%%
%path = 'Data_train_init';z = 0:2;
%path = 'Data_train_rotate_360';z = 2;
%path = 'Data_train_rotate_90';z = 2;
%path = 'Data_analyse_error';z = 2;
%path = 'Data_test';z = 2;
path = 'Data_databases_test';z = 2;
%%
[data, labels] = OpenData(path);
[~,~,group] = unique(labels(:,1));
[X,Y, Z] = meshgrid(0:10, 0:10, z);
param =  [X(:) Y(:) Z(:)];
[features, featuresNorm] = GenFeatures(data, param);
%%
%param(243,:) = []; uncomment for Data_train_init
%%
param([1, 2, 12],:) = []; featuresNorm(:,[1 11]) = []; % comment for Data_train_init
%%
mkdir('Save')
save(['Save/', path], 'data', 'group', 'param', 'features', 'featuresNorm')
