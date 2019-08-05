clc; clear all; close all;
filename='temperature_global.xlsx';
data = xlsread(filename);                   % reads the data from excel 
data(:,1)=[];                               % remove year
     
   xbar=mean(data);                         % mean of columns of experimental samples 
   sigma=std(data);                         % standard deviation of columns of experimental samples
   [m,n]=size(data);                        % get size of  experimental samples
   NormA=data-(ones(m,1)*xbar);             % mean shift
   NormA=NormA./(ones(m,1)*sigma);          % scale by standard deviation
   X=NormA(:,[1:n-1]);                      % extract input experimental data
   Y=NormA(:,n);                            % extract output experimental data
   alpha_O=inv(X.'*X)*X.'*Y;                % OLS slope estimate
   beta=mean(Y)-alpha_O.'*mean(X).';        % OLS constant estimate
    
   Z=[X Y];
   S=Z.'*Z;                                 % Covariance matrix
   [V,D]=eig(S);                            % V - eigen vector matrix, D- eigen values
   alpha_T=-V(:,1)/V(n,1)  ;                % TLS estimates
   alpha_T(n)=[];                           % Remove the output vector
  
   fprintf('\n\n--------------------------------------------------------\n')
   fprintf('\n The OLS and TLS estimates respectively are, \n')
     alpha= [alpha_O alpha_T]
   fprintf('\n--------------------------------------------------------\n')