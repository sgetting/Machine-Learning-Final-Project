%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% UCI - CS 178 Final Project
% Fall 2012
% 2009 KDD Cup
% Team uci178-SGJD
%   Team Members:
%       Jerome Domingo
%       Scott Gettinger
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Classifier using bootstrap aggregartion on decision trees
%

close all
clear all
clc

Nbag = 200; % use this many decision trees
Nuse = 5000; % use this many points at a time
Nfeat = 80;
MinParents = 30;


%% Part 1: Churn
disp('Starting Churn...')
% Data setup
load('project_small_train_churn_X');

load('project_small_train_churn_Y');

load('project_small_test_X');
Xtest_final = Xte;
clear Xte;

% Loop: for each target Y category:

[Xtr, Ytr] = reorderData(Xtr_churn,Y_churn);
clear Xte Xtr_churn Y_churn;
% [Xtr, Xte, Ytr, Yte] = splitData(X,Y,.75); % split given data into train (75%) and test (25%)

% Bootstrap aggregation procedure:
%   (from CS 178 Fall 2012 lecture slides)

disp('Starting Bagging...')
[N,D] = size(Xtr);
Classifiers = cell(1,Nbag); % Allocate space
feat = zeros(Nbag,Nfeat);
for i=1:Nbag
    fprintf('Bagging Number %d...\n',i)
    ind = ceil( N*rand(Nuse, 1) ); % Bootstrap sample data
    feat(i,:) = randperm(D,Nfeat); % Select random features without replacement
    Xi = Xtr(ind, feat(i,:)); Yi = Ytr(ind, :); % Select those indices
    Classifiers{i} = ClassificationTree.fit(Xi, Yi, 'MinParent', MinParents, 'SplitCriterion', 'deviance'); % Train
end;

% Test data Xtest
[Ntest,D] = size(Xtest_final);
predict_test = zeros(Ntest,Nbag); % Allocate space
for i=1:Nbag, % Apply each classifier
    [label, score] = Classifiers{i}.predict(Xtest_final(:,feat(i,:)));
    % use score(:,2) for mean of all scores, (label(:,1)+1)/2 for mean of predictions
    predict_test(:,i) = score(:,2); 
end;
predict_test = mean(predict_test,2); % mean of output
clear Xtest_final;

Xtrain = load('orange_small_train');
Xtrain = Xtrain.X;
Xtrain = Xtrain(:,any(Xtrain));
% Test data Xtest
[Ntest,D] = size(Xtrain);
predict_train = zeros(Ntest,Nbag); % Allocate space
for i=1:Nbag, % Apply each classifier
    [label, score] = Classifiers{i}.predict(Xtrain(:,feat(i,:)));
    predict_train(:,i) = score(:,2);
end;
predict_train = mean(predict_train,2); % mean of output


TestFile = fopen('results/orange_small_test_churn.resu','w');
TrainFile = fopen('results/orange_small_train_churn.resu','w');
fprintf(TestFile,'%0.8f\n',predict_test);
fprintf(TrainFile,'%0.8f\n',predict_train);
% save('results/orange_small_test_churn.resu','predict_test','-ascii');
% save('results/orange_small_train_churn.resu','predict_train','-ascii');


%% Part 2: Appetency
clear X* Y*;
clear Classifiers;

disp('Starting Appetency...')
% Data setup
load('project_small_train_appetency_X');

load('project_small_train_appetency_Y');

load('project_small_test_X');
Xtest_final = Xte;

% Loop: for each target Y category:

[Xtr, Ytr] = reorderData(Xtr_appetency,Y_appetency);
clear Xte Xtr_appetency Y_appetency;
% [Xtr, Xte, Ytr, Yte] = splitData(X,Y,.75); % split given data into train (75%) and test (25%)

% Bootstrap aggregation procedure:
%   (from CS 178 Fall 2012 lecture slides)

disp('Starting Bagging...')
[N,D] = size(Xtr);
Classifiers = cell(1,Nbag); % Allocate space
feat = zeros(Nbag,Nfeat);
for i=1:Nbag
    fprintf('Bagging Number %d...\n',i)
    ind = ceil( N*rand(Nuse, 1) ); % Bootstrap sample data
    feat(i,:) = randperm(D,Nfeat); % Select random features without replacement
    Xi = Xtr(ind, feat(i,:)); Yi = Ytr(ind, :); % Select those indices
    Classifiers{i} = ClassificationTree.fit(Xi, Yi, 'MinParent', MinParents, 'SplitCriterion', 'deviance'); % Train
end;

% Test data Xtest
[Ntest,D] = size(Xtest_final);
predict_test = zeros(Ntest,Nbag); % Allocate space
for i=1:Nbag, % Apply each classifier
    [label, score] = Classifiers{i}.predict(Xtest_final(:,feat(i,:)));
    predict_test(:,i) = score(:,2);
end;
predict_test = mean(predict_test,2); % mean of output
clear Xtest_final;

Xtrain = load('orange_small_train');
Xtrain = Xtrain.X;
Xtrain = Xtrain(:,any(Xtrain));
% Test data Xtest
[Ntest,D] = size(Xtrain);
predict_train = zeros(Ntest,Nbag); % Allocate space
for i=1:Nbag, % Apply each classifier
    [label, score] = Classifiers{i}.predict(Xtrain(:,feat(i,:)));
    predict_train(:,i) = score(:,2);
end;
predict_train = mean(predict_train,2); % mean of output


TestFile = fopen('results/orange_small_test_appetency.resu','w');
TrainFile = fopen('results/orange_small_train_appetency.resu','w');
fprintf(TestFile,'%0.8f\n',predict_test);
fprintf(TrainFile,'%0.8f\n',predict_train);
% save('results/orange_small_test_appetency.resu','predict_test','-ascii');
% save('results/orange_small_train_appetency.resu','predict_train','-ascii');

%% Part 3: Upselling
clear X* Y*;
clear Classifiers;

disp('Starting Upselling...')
% Data setup
load('project_small_train_upselling_X');

load('project_small_train_upselling_Y');

load('project_small_test_X');
Xtest_final = Xte;


% Loop: for each target Y category:

[Xtr, Ytr] = reorderData(Xtr_upselling,Y_upselling);
clear Xte Xtr_upselling Y_upselling;
% [Xtr, Xte, Ytr, Yte] = splitData(X,Y,.75); % split given data into train (75%) and test (25%)

% Bootstrap aggregation procedure:
%   (from CS 178 Fall 2012 lecture slides)

disp('Starting Bagging...')
[N,D] = size(Xtr);
Classifiers = cell(1,Nbag); % Allocate space
feat = zeros(Nbag,Nfeat);
for i=1:Nbag
    fprintf('Bagging Number %d...\n',i)
    ind = ceil( N*rand(Nuse, 1) ); % Bootstrap sample data
    feat(i,:) = randperm(D,Nfeat); % Select random features without replacement
    Xi = Xtr(ind, feat(i,:)); Yi = Ytr(ind, :); % Select those indices
    Classifiers{i} = ClassificationTree.fit(Xi, Yi, 'MinParent', MinParents, 'SplitCriterion', 'deviance'); % Train
end;

% Test data Xtest
[Ntest,D] = size(Xtest_final);
predict_test = zeros(Ntest,Nbag); % Allocate space
for i=1:Nbag, % Apply each classifier
    [label, score] = Classifiers{i}.predict(Xtest_final(:,feat(i,:)));
    predict_test(:,i) = score(:,2);
end;
predict_test = mean(predict_test,2); % mean of output
clear Xtest_final;

Xtrain = load('orange_small_train');
Xtrain = Xtrain.X;
Xtrain = Xtrain(:,any(Xtrain));
% Test data Xtest
[Ntest,D] = size(Xtrain);
predict_train = zeros(Ntest,Nbag); % Allocate space
for i=1:Nbag, % Apply each classifier
    [label, score] = Classifiers{i}.predict(Xtrain(:,feat(i,:)));
    predict_train(:,i) = score(:,2);
end;
predict_train = mean(predict_train,2); % mean of output


TestFile = fopen('results/orange_small_test_upselling.resu','w');
TrainFile = fopen('results/orange_small_train_upselling.resu','w');
fprintf(TestFile,'%0.8f\n',predict_test);
fprintf(TrainFile,'%0.8f\n',predict_train);
% save('results/orange_small_test_upselling.resu','predict_test','-ascii');
% save('results/orange_small_train_upselling.resu','predict_train','-ascii');