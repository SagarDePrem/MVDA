clear all;
clc;
load('steamdata.mat')
[nvar nsamples]=size(Fmeas);
m=11;           % number of constraints
Y=Fmeas;        % data matrix of measurements
Sy=Y*Y';        % data covariance matrix
stderr=0.001*Sy;           % error covariance matrix initial guess
L=chol(stderr);             % Cholesky decomposition
L=L';
Ys=inv(L)*Y;                % transformation

[U S V]=svd(Ys);            % svd of transformed data
Lambda=diag(S'*S);                   % eigen values
plot(log(Lambda),'*')           % SCREE plot
xlabel('variables')
ylabel('log(\lambda)')
title('SCREE plot')