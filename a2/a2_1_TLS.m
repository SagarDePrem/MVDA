clc; clear all; close all;
filename='windedata.xlsx';
wine = xlsread(filename, 'White Wine');     % reads the data from excel 
   xbar=mean(wine)   ;                     % mean of columns of experimental samples 
   sigma=std(wine)  ;                      % standard deviation of columns of experimental samples
   [m,n]=size(wine);                       % get size of  experimental samples
   NormA=wine-(ones(m,1)*xbar);            % mean shift
   NormA =NormA./(ones(m,1)*sigma);        % scale by standard deviation
  
   X=NormA(1:3430,[1:n-1]);                % extract input experimental data
   Y=NormA(1:3430,n);                      % extract output experimental data
   Z=[X Y];
   S=Z.'*Z;                        % Covariance matrix
   [V,D]=eig(S);                           % V - eigen vector matrix, D- eigen values
   alpha_T=-V(:,1)/V(n,1)  ;                % TLS estimates
   alpha_T(n)=[];                          % Remove the output vector
   alpha_T
   %beta=mean(Y)-alpha_T.'*mean(X).';       % OLS constant estimate
   Y1=NormA(3431:4898,n);                  % actual values of test samples
   Y2=NormA(3431:4898,1:n-1)*alpha_T;    % model prediction for test samples
   RMSD =sqrt((Y1-Y2).'*(Y1-Y2)/(4898-3430));% root mean square deviation
 
fprintf('\n\n--------------------------------------------------------\n')
fprintf('\n Root mean square deviation for OLS of White wine test samples \n')
fprintf(' RMSD = %s\n', RMSD)
fprintf('\n--------------------------------------------------------\n')

 