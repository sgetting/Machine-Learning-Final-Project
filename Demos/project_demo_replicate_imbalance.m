clear all
mkdir results

% import the features
load orange_small_train;
[Xtrain, R] = imputeMissing(X,'median');
load orange_small_test;
Xtest = imputeMissing(X, 'median', R);
 

% import the training labels (downloaded from http://www.kddcup-orange.com/data.php)
YCell{1} = importdata('orange_small_train_churn.labels');
YCell{2} = importdata('orange_small_train_upselling.labels');
YCell{3} = importdata('orange_small_train_appetency.labels'); 

% decision tree for chrun
for i=1:3    
    % duplicate all the data points with label 1 for 10 times
    dx = find(YCell{i}==1); dx2 = find(YCell{i}==-1);
    Xtrain1 = Xtrain([repmat(dx,10,1); dx2], :);
    % run the decision tree classifier
    objCell{i} = treeClassify(Xtrain1, YCell{i}([repmat(dx,10,1); dx2]));
    labs_train{i} = predict(objCell{i}, Xtrain);
    labs_test{i} = predict(objCell{i}, Xtest);
end
tmp1 = labs_train{1};  tmp2 = labs_test{1};
save results/orange_small_train_churn.resu tmp1 -ascii
save results/orange_small_test_churn.resu tmp2 -ascii

tmp1 = labs_train{2};  tmp2 = labs_test{2};
save results/orange_small_train_upselling.resu tmp1 -ascii
save results/orange_small_test_upselling.resu tmp2 -ascii

tmp1 = labs_train{3};  tmp2 = labs_test{3};
save results/orange_small_train_appetency.resu tmp1 -ascii
save results/orange_small_test_appetency.resu tmp2 -ascii

% zip the results
!zip results/results.zip results/*resu

% go to http://www.kddcup-orange.com/submit.php and submit rsults.zip
% The result is significantly better than that without duplication !!!
%result: 0.6814	0.6168	0.7418	0.5877	0.7884	0.7295	0.6446

