function [ Xout, Yout ] = replicateImbalance( X, Y , Yvals)
%replicateImbalance decreases imbalance between classes in Y
%   Detailed explanation goes here
    numInstances = zeros(1,length(Yvals));
    Yout = Y;
    Xout = X;
    for i = 1:length(Yvals)
        Ynums(i) = sum(Y==Yvals(i));
    end
    for i = 1:length(Yvals)
        numInstances(i) = Ynums(i);
        if (numInstances(i) < max(Ynums))
            possReps = find(Y == Yvals(i)); % indices where Y = Yvals
            numReps = max(Ynums) - numInstances(i);
            reps = randi(length(possReps),1,numReps); % indices that will be repeated
            Xreps = zeros(numReps,size(X,2));
            Yreps = zeros(numReps,1);

            Xreps = X(possReps(reps),:);
            Yreps = Y(possReps(reps),:);
            
            Xout = vertcat(Xout,Xreps);
            Yout = vertcat(Yout,Yreps);
        end %if
    end %for

end %function

