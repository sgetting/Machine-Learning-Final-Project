%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% UCI - CS 178 Final Project
% 2009 KDD Cup
% Team uci178-
%   Team Members:
%       Jerome Domingo
%       Scott Gettinger
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Close windows, clear variables, clear screen
close all;
clear all;
clc;

Xfile = 'test'

% Load data

X = load(sprintf('orange_small_%s',Xfile));
X = X.X;

% Y_appetency = load('orange_small_train_appetency.labels', '-ascii');
% Y_churn = load('orange_small_train_churn.labels', '-ascii');
% Y_upselling = load('orange_small_train_upselling.labels', '-ascii');

% Set up the data

load('orange_small_train.mat');

% Remove columns with all 0 or all NaN
Xsmall = X(:,1);
for n = 2:230
    useful = any(X(:,n));
    if(useful)
        Xsmall = horzcat(Xsmall,X(:,n));
    end
end

X = Xsmall;

% Set NaN (missing data) in each feature 
%  to the median value for that feature
%  (imputing data)
for n = 1:size(X,2)
    medians(n)=median(X(~isnan(X(:,n)),n));
    for k = 1:size(X,1)
    	if(isnan(X(k,n)))
            X(k,n) = median(n);
    	end
    end
end

% Save in a file for later loading
save(sprintf('data_modified_%s',Xfile),'X');

% % Test and predictions section:
% 
% Load test data
% load('orange_small_test.mat');