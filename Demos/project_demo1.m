close all
clear all
clc

mkdir results

% import the features
load orange_small_train;
[Xtrain, R] = imputeMissing(X,'median');
load orange_small_test;
Xtest = imputeMissing(X, 'median', R);

% import the training labels (downloaded from http://www.kddcup-orange.com/data.php)
chrun = importdata('orange_small_train_churn.labels');
upselling = importdata('orange_small_train_upselling.labels');
appetency = importdata('orange_small_train_appetency.labels'); 

% decision tree for chrun
obj_chrun = treeClassify(Xtrain, chrun);
chrun_train = predict(obj_chrun, Xtrain);
chrun_test = predict(obj_chrun, Xtest);
% save the results into text file
save results/orange_small_train_churn.resu chrun_train -ascii  
save results/orange_small_test_churn.resu chrun_test -ascii

% decision tree for upselling
obj_upselling = treeClassify(Xtrain, upselling);
upselling_train = predict(obj_upselling, Xtrain);
upselling_test = predict(obj_upselling, Xtest);
save results/orange_small_train_upselling.resu upselling_train -ascii
save results/orange_small_test_upselling.resu upselling_test -ascii

% decision tree for appetency
obj_appetency = treeClassify(Xtrain, appetency);
appetency_train = predict(obj_appetency, Xtrain);
appetency_test = predict(obj_appetency, Xtest);
save results/orange_small_train_appetency.resu appetency_train -ascii 
save results/orange_small_test_appetency.resu appetency_test -ascii

% zip the results
!zip results/results.zip results/*resu 
 
%go to http://www.kddcup-orange.com/submit.php and submit rsults.zip  (you need to regist an account first)
%the result I get: [0.5415	0.5067	0.5851	0.5111	0.7326	0.6973	0.5717];
%%

