clc; clear all; close all;
filename='windedata.xlsx';
wine = xlsread(filename, 'Red Wine');       % reads the Red wine data from excel 
   p=1120;q=1599;                           % number of experimental samples and total samples
   xbar=mean(wine);                         % mean of columns of experimental samples 
   sigma=std(wine);                         % standard deviation of columns of experimental samples
   [m,n]=size(wine);                        % get size of  experimental samples
  
   NormA=wine-(ones(m,1)*xbar);             % mean shift
   NormA=NormA./(ones(m,1)*sigma);          % scale by standard deviation
 
   X=NormA(1:p,[1:n-1]);                    % extract input experimental data
   Y=NormA(1:p,n);                          % extract output experimental data
  
   alpha_O=inv(X.'*X)*X.'*Y   ;             % OLS slope estimate
   beta=mean(Y)-alpha_O.'*mean(X).';        % OLS constant estimate
   Y1=NormA(p+1:q,n);                       % actual values of test samples
   Y_O=NormA(p+1:q,[1:n-1])*alpha_O;        % OLS model prediction for test samples
   RMSD_O =sqrt((Y1-Y_O).'*(Y1-Y_O)/(q-p-1));   % root mean square deviation of OLS
   
    Z=[X Y];
   S=Z.'*Z;                                 % Covariance matrix
   [V,D]=eig(S);                            % V - eigen vector matrix, D- eigen values
   alpha_T=-V(:,1)/V(n,1)  ;                % TLS estimates
   alpha_T(n)=[];                           % Remove the output vector
   Y_T=NormA(p+1:q,1:n-1)*alpha_T;              % TLS model prediction for test samples
   RMSD_T =sqrt((Y1-Y_T).'*(Y1-Y_T)/(q-p-1));   % root mean square deviation of TLS
 [alpha_O alpha_T]
fprintf('\n\n--------------------------------------------------------\n')
fprintf('\n Root mean square deviation for OLS of Red wine test samples \n')
fprintf(' RMSD = %s\n', RMSD_O)
fprintf('\n Root mean square deviation for TLS of Red wine test samples \n')
fprintf(' RMSD = %s\n', RMSD_T)
fprintf('\n--------------------------------------------------------\n')

 