clc; clear all; close all;
filename='windedata.xlsx';
wine = xlsread(filename, 'Red Wine');     % reads the data from excel 
   p=1120;q=1599;
   xbar=mean(wine);                     % mean of columns of experimental samples 
   sigma=std(wine);                      % standard deviation of columns of experimental samples
   [m,n]=size(wine);                       % get size of  experimental samples
  
   NormA=wine-(ones(m,1)*xbar);            % mean shift
   NormA=NormA./(ones(m,1)*sigma);        % scale by standard deviation
 
   X=NormA(1:p,[1:n-1]);                % extract input experimental data
   Y=NormA(1:p,n);                      % extract output experimental data
  
   alpha_O=inv(X.'*X)*X.'*Y                % OLS slope estimate
   beta=mean(Y)-alpha_O.'*mean(X).';       % OLS constant estimate
   Y1=NormA(p+1:q,n);                  % actual values of test samples
   Y2=NormA(p+1:q,[1:n-1])*alpha_O;    % model prediction for test samples
   RMSD_O =sqrt((Y1-Y2).'*(Y1-Y2)/(q-p-1));% root mean square deviation
 
fprintf('\n\n--------------------------------------------------------\n')
fprintf('\n Root mean square deviation for OLS of White wine test samples \n')
fprintf(' RMSD = %s\n', RMSD_O)
fprintf('\n--------------------------------------------------------\n')

 