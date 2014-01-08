%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% UCI - CS 178 Final Project
% 2009 KDD Cup
% Team uci178-SGJD
%   Team Members:
%       Jerome Domingo
%       Scott Gettinger
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Close windows, clear variables, clear screen
close all;
clear all;
clc;

print = true;

% Load data
if print,disp('Loading Data...'),end;
Xtr = load('orange_small_train');
Xtr = Xtr.X;

Xte = load('orange_small_test');
Xte = Xte.X;

Y_appetency = importdata('orange_small_train_appetency.labels');
Y_churn = importdata('orange_small_train_churn.labels');
Y_upselling = importdata('orange_small_train_upselling.labels');

% Set up the data

% Remove columns with all 0 or all NaN
if print,disp('Removing Useless Columns...'),end;
useful = any(Xtr(:,:));
Xtr = Xtr(:,useful);

Xte = Xte(:,useful);

% if print,disp('Imputing With Medians...'),end;
% % Set NaN (missing data) in each feature 
% %  to the median value for that feature
% %  (imputing data)
% % NOTE: this step is only done for the training data.
% for n = 1:size(Xtr,2)
%     medians(n)=median(Xtr(~isnan(Xtr(:,n)),n));
%     Xtr(isnan(Xtr(:,n)),n) = medians(n);
% end

if print,disp('Replicating Imbalance: Appetency...'),end;
[Xtr_appetency, Y_appetency] = replicateImbalance(Xtr,Y_appetency, [-1 1]);

if print,disp('Replicating Imbalance: Churn...'),end;
[Xtr_churn, Y_churn] = replicateImbalance(Xtr,Y_churn, [-1 1]);

if print,disp('Replicating Imbalance: Upselling...'),end;
[Xtr_upselling, Y_upselling] = replicateImbalance(Xtr,Y_upselling, [-1 1]);

% Save in a file for later loading
if print,disp('Saving Data...'),end;

save('project_small_test_X','Xte');

save('project_small_train_appetency_X','Xtr_appetency');
save('project_small_train_churn_X','Xtr_churn');
save('project_small_train_upselling_X','Xtr_upselling');

save('project_small_train_appetency_Y','Y_appetency');
save('project_small_train_churn_Y','Y_churn');
save('project_small_train_upselling_Y','Y_upselling');

if print,disp('Done.'),end;