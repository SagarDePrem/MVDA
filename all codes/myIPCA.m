function [Rhat,Ahat,maxerror,sumS]=myIPCA(Rtrue,Y,std,m,nind,tol)
%%
% Inputs:
%       Rtrue - true regression matrix
%       Y     - data matrix nvariables x Nsamples
%       std   - error standared deviation for the variables
%       m     - number of constraints
%       nind  - number of independent variables
%       tol   - tolerance
% Outputs:
%       Rhat  - estimated regression model
%       Ahat  - estimated constraint model
%       maxerr   - maximum error between true and estimated regression models
%       s     - sum of last m eigen values

[nvar nsamples]=size(Y);    % get size of  experimental samples
Sy=Y*Y'/nsamples;           % data covariance matrix
%% initialize
    k=0;                % counter
    s0=0;       
    err=1;
%% Initial guess 
for i=1:nvar
   stderr(i,i)=0.0001*Sy(i,i);      % initialize error covariance matrix
end

%% Initial guess from PCA
%  Ahat =myPCA1(Y,std,m);
%  stderr=diag(stdest(Ahat,Y));
%% IPCA to estimate constraint model and error covariance matrix

while(err>tol)
    L=chol(stderr,'lower');             % Cholesky decomposition
    Ys=inv(L)*Y;                        % transformation
    [U S V]=svd(Ys);                    % svd of transformed data
    Ahat=(U(:,nvar-m+1:nvar))'*inv(L);  % constraint matrix of original data
    s=diag(S);                          % singular values
    sumS=sum(s(nvar-m+1:nvar));         % sum of last m singular values
    err=abs(sumS-s0);                   % relative error in last m singular value sum
    s0=sumS; 
    stderr=diag(stdest(Ahat,Ys));       % new estimate for error covariance matrix
    fprintf('IPCA iteration %d\n',k)
    k=k+1;
end
%%
Rhat=-(Ahat(:,nind+1:nvar)\Ahat(:,1:nind));
maxerror=max(max(abs(Rtrue-Rhat)));
