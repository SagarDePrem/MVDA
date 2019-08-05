function [Rhat,Ahat,err,s]=myPCA(Rtrue,Y,std,m,nind)
%%
% Inputs:
%       Rtrue - true regression matrix
%       Y     - data matrix nvariables x Nsamples
%       std   - error standared deviation for the variables
%       m     - number of constraints
%       nind  - number of independent variables
% Outputs:
%       Rhat  - estimated regression model
%       Ahat  - estimated constraint model
%       err   - maximum error between true and estimated regression models
%       s     - sum of last m singular values

%%

    [n,N]=size(Y);                     % get size of  experimental samples
    xbar=(mean(Y'))';                  % mean of variable acroess samples 
    scale=std*ones(1,N);               % use the given std
    Y=Y-xbar*(ones(1,N));              % mean shift
    Y=Y./scale;                        % scale
    Ss=Y*Y'/N;                         % covariance matrix
    [U S V] = svd(Ss);                 % svd
    s=sum(diag(S(n-m+1:n)).^0.5);           % sum of last m eigen values
    Ahat = U(:,n-m+1:n)'*diag(1./std);           % Estimated constraint model in unscaled variables
    Rhat=regress(Ahat(:,nind+1:n),Ahat(:,1:nind));  % Estimated regression matrix
    err=max(max(Rtrue-Rhat)) ;                      % maximum error
end