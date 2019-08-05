function [ Ahat ]=myPCA1(Y,std,m)

[n,N]=size(Y);                        % get size of  experimental samples
    xbar=mean(Y);                         % mean of columns of experimental samples 
   scale=std*ones(1,N);
    Y=Y-(ones(n,1)*xbar);             % mean shift
   Y=Y./scale;                      % scale by standard deviation
   Ss=Y*Y'/N;                       % covariance matrix
   [U S V] = svd(Ss);                       % svd
   Ahat = U(:,n-m+1:n)'*diag(1./std);                    % Estimated constraint model in unscaled variables
     