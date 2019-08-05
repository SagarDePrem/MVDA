clear
clc
load('steamdata.mat')
[nvar nsamples]=size(Fmeas);
m=15;           % number of constraints
Y=Fmeas;        % data matrix of measurements
Sy=Y*Y'/nsamples;        % data covariance matrix
%% initialize
    k=0;            % counter
    lambda0=0;       
    tol=0.05;    % error tolerance
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
    L=chol(stderr);             % Cholesky decomposition
    L=L';
    Ys=inv(L)*Y;                % transformation
    [U ,S ,V]=svd(Ys);            % svd of transformed data
    A=(U(:,nvar-m+1:nvar))'*inv(L);     % constraint matrix of original data
    % Lambda1=diag(S.*S);
    Lambda1=diag(S);
    Lambda=Lambda1(nvar-m+1:nvar);                   % eigen values
    lambda=sum(Lambda);             % sum of singular values
    err=abs(lambda-lambda0);            % relative error in singular value sum
    lambda0=lambda; 
    stderr=diag(stdest(A,Ys));           % new estimate for error covariance matrix
    k=k+1                              
end
%%
% Compare Atrue and A
% theta_pca = 180*subspace(Atrue', A')/pi
% Determine how well the model matches with the true constraint matrix.
% For this determine the minimum distance of each true constraint vector from the
% row space of model constraints
% for i = 1:3
%     bcol = Atrue(i,:)';
%     dist_pca(i) = norm(bcol - A'*inv(A*A')*A*bcol);
% end
% DIST_PCA=norm(dist_pca)
%%
plot(log(Lambda1),'*')           % SCREE plot
% xlabel(' ')
ylabel('log(\lambda)')
title('SCREE plot for m=20')
%%
% true regression model
nind=17;   % number of independent variables
% Rtrue=-Atrue(:,1:nind)\Atrue(:,nind+1:nvar);
% Rtrue=-inv(Atrue(:,nind+1:nvar)'*Atrue(:,nind+1:nvar))*(Atrue(:,nind+1:nvar))'*Atrue(:,1:nind);
% estimated regression model
% Rhat=-A(:,1:nind)\A(:,nind+1:nvar);
%  Rhat=-inv(A(:,nind+1:nvar)'*A(:,nind+1:nvar))*(A(:,nind+1:nvar))'*A(:,1:nind);
Rtrue=regress(Atrue(:,nind+1:nvar),Atrue(:,1:nind));
Rhat=regress(A(:,nind+1:nvar),A(:,1:nind));
maxerror=max(max(abs(Rtrue-Rhat)))
eig=diag(S.^2);
