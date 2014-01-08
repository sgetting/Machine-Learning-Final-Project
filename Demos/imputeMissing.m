function [X,R] = imputeMissing(X,method,R);

[N,F] = size(X);  % N data, F features

if (nargin < 3)
  switch(method),

  case 'median',
    R = zeros(1,F);
    for i=1:F,
      R(i) = median(X( ~isnan(X(:,i)), i));
      if (isnan(R(i))) R(i)=0; end;
    end;
  
  case 'gaussian',
    R={ zeros(1,F), zeros(F,F) };
    for i=1:F,
      R{1}(i) = mean(X( ~isnan(X(:,i)), i));
    end;
    for i=1:F, for j=1:F,
      nans = isnan(X(:,i)) || isnan(X(:,j));
      R{2}(i,j) = mean( (X(~nans,i)-R{1}(i)).*(X(~nans,j)-R{1}(j)) );
    end; end;
  
  end;
end;

switch(method),
  case 'median',
    for i=1:F, X( isnan(X(:,i)),i )=R(i); end;
  case 'gaussian',
    for i=1:N,
    end;
end;
