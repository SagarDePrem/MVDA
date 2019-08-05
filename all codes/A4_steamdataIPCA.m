clear
clc
load('steamdata.mat')
[nvar nsamples]=size(Fmeas);
m=11;           % number of constraints
% note that if the error covariance matrix is diagonal 0.5*m(m+1)>=nvar     
% so choose m accordingly
Y=Fmeas;                 % data matrix of measurements
Sy=Y*Y'/nsamples;        % data covariance matrix
% set tolerances to IPCA wherever used
%% initialize
    k=0;            % counter
    s0=0;       
    tol=0.0008;      % error tolerance
    err=1;
    
%% initial guess

    for i=1:nvar
        stderr(i,i)=0.0001*Sy(i,i); 
    end
    
%% Initial guess from PCA

%  Ahat =myPCA1(Y,std,m);
% stderr=diag(stdest(Ahat,Y));

%% IPCA to estimate constraint model and error covariance matrix

while(err>tol)
    %  for i=1:1
    L=chol(stderr,'lower');             % Cholesky decomposition
    Ys=inv(L)*Y;                        % transformation
    [U ,S ,V]=svd(Ys);                  % svd of transformed data
    A=(U(:,nvar-m+1:nvar))'*inv(L);     % constraint matrix of original data
    s=diag(S);                          % singular values
    sumS=sum(s(nvar-m+1:nvar));         % sum of last m singular values
    err=abs(sumS-s0);                   % relative error in singular value sum
    s0=sumS; 
    stderr=diag(stdest(A,Ys));          % new estimate for error covariance matrix
    k=k+1;
    fprintf('IPCA iteration %d\n',k)
end

%%   SCREE plot
plot(log(s.^2),'*')          
xlabel('PCs')
ylabel('log(\lambda)')
title('SCREE plot for the chosen constraints m')

%% Compare regression models if first nind variables are independent
 
nind=17;                                        % number of independent variables
Rtrue=-Atrue(:,nind+1:nvar)\Atrue(:,1:nind);    % true regression model
Rhat=-A(:,nind+1:nvar)\A(:,1:nind);             % estimated regression model
maxerror=max(max(abs(Rtrue-Rhat)))              % max erro
eig=diag(S).^2;
