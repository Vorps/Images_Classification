clear;clc; close all;
path = './base_data/';
S = dir([path, '/*.png']);
length = numel(S);
for k = 1:length
    data(:,:, k) = imread(fullfile(path,S(k).name));
    labels{k} = regexprep(S(k).name, '.png', '');
end
%% Train initial
mkdir('Data_train_init')
pathResult = './Data_train_init/';
for i = 1:size(data,3)
    for degree = 0:45:360-45
        for zoom = 0.5:0.5:3
            [I, dim] = ImTransform(data(:,:,i), [zoom*cos(degree*2*pi/360), zoom*sin(degree*2*pi/360) 0; -zoom*sin(degree*2*pi/360) zoom*cos(degree*2*pi/360) 0; 0 0 1]);
            [X, Y] = meshgrid([dim(2)/2, 0, -dim(6)/2], [dim(1)/2, 0, -dim(5)/2]);
            U = [X(:), Y(:)];
            for pos = U'
                x = pos(1);
                y = pos(2);
                Im = ImTransform(I, [1, 0, x; 0, 1, y; 0 0 1]);
                imwrite(Im, [pathResult, labels{i}, '_', num2str(degree, '%03.0f'), '_', num2str(zoom*10, '%02.0f'), '_', num2str(x, '%03.0f'), '_', num2str(y, '%03.0f'), '.png'])
            end
        end
    end
end
%% Test
mkdir('Data_test')
pathResult = './Data_test/';
for i = 1:size(data,3)
    for degree = 0:45:360-45
        for zoom = [0.5 1.5 2 2.5 3]
            [I, dim] = ImTransform(data(:,:,i), [zoom*cos(degree*2*pi/360), zoom*sin(degree*2*pi/360) 0; -zoom*sin(degree*2*pi/360) zoom*cos(degree*2*pi/360) 0; 0 0 1]);
            [X, Y] = meshgrid([dim(2)/2, 0, -dim(6)/2], [dim(1)/2, 0, -dim(5)/2]);
            U = [X(:), Y(:)];
            for pos = U'
                x = pos(1);
                y = pos(2);
                Im = ImTransform(I, [1, 0, x; 0, 1, y; 0 0 1]);
                imwrite(Im, [pathResult, labels{i}, '_', num2str(degree, '%03.0f'), '_', num2str(zoom*10, '%02.0f'), '_', num2str(x, '%03.0f'), '_', num2str(y, '%03.0f'), '.png'])
            end
        end
    end
end
%% Train rotation 360
mkdir('Data_train_rotate_360')
pathResult = './Data_train_rotate_360/';
for i = 1:size(data,3)
    for degree = 0:1:360-1
        I =  ImTransform(data(:,:,i), [cos(degree*2*pi/360), sin(degree*2*pi/360) 0; -sin(degree*2*pi/360) cos(degree*2*pi/360) 0; 0 0 1]);
        imwrite(I, [pathResult, labels{i}, '_', num2str(degree, '%03.0f'), '.png'])
    end
end
%% Train rotation 90
mkdir('Data_train_rotate_90')
pathResult = './Data_train_rotate_90/';
for i = 1:size(data,3)
    for degree = 0:1:90
        I =  ImTransform(data(:,:,i), [cos(degree*2*pi/360), sin(degree*2*pi/360) 0; -sin(degree*2*pi/360) cos(degree*2*pi/360) 0; 0 0 1]);
        imwrite(I, [pathResult, labels{i}, '_', num2str(degree, '%03.0f'), '.png'])
    end
end
%% Data Analyse Error
mkdir('Data_Analyse_Error')
pathResult = './Data_Analyse_Error/';
for i = 1:size(data,3)
    for degree = 0:1:90
        for zoom = 0.5:0.1:3
            I = ImTransform(data(:,:,i), [zoom*cos(degree*2*pi/360), zoom*sin(degree*2*pi/360) 0; -zoom*sin(degree*2*pi/360) zoom*cos(degree*2*pi/360) 0; 0 0 1]);
            imwrite(I, [pathResult, labels{i}, '_', num2str(degree, '%03.0f'), '_', num2str(zoom*10, '%02.0f'), '.png'])
        end
    end
end
%% Database
path = './Database/';
pathResult = './Data_databases_test/';
mkdir(pathResult)
S = dir([path, '/*.png']); 
for k = 1:160
    movefile([path, S(k).name],[path, 'Clubs_', num2str(k, '%03.0f'), '.png'],'f');
end
for k = 161:320
    movefile([path, S(k).name],[path, 'Diamonds_', num2str(k-160, '%03.0f'), '.png'],'f');
end
for k = 321:480
    movefile([path, S(k).name],[path, 'Hearts_', num2str(k-320, '%03.0f'), '.png'],'f');
end
for k = 481:640
    movefile([path, S(k).name],[path, 'Spades_', num2str(k-480, '%03.0f'), '.png'],'f');
end
S = dir([path, '/*.png']); 
for k = 1:numel(S)
    data = rgb2gray(imread(fullfile(path,S(k).name))) < 128;
    imwrite(data,[pathResult,S(k).name])
end
