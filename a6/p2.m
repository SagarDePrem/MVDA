clear
clc
load('arx.mat')
%% 
u=fliplr(umeas);        
y=fliplr(ymeas);
u1=u(2:1000)';
p=1;

%% Construct the input matrix A

for i=1:999
        if i+p<1000
        A(i,:)=y(i+1:i+p);  
        end
        if i+p>=1000
        A(i,:)=[y(i+1:1000) zeros(1,i+p-1000)];  
        end 
      end
A=[A u1];
%% OLS regression
% a=A\y(1:999)';          % the coefficients
% ypred=A*a;              % model prediction
% maxerr=max(abs(y(1:999)'-ypred)) % error in prediction 
 %% TLS
  A1=[y(1:999)' A]';
 [u1 s v]=svd(A1);
 N=u1(:,3);
 a=[-N(2)/N(1), -N(3)/N(1)]
%   plot(log((diag(s)).^2))