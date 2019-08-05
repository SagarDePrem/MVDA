% Question 01 AE14B021
clear
clc
load('tg.mat')
%% Part A OLS
% independent variable
Y=Tgpolymers(:,13);          % tranisition temperatures assumed  perfect
X=Tgpolymers(:,1:12);        % dependent variables
xbar=(ones(12,1)*mean(X'))' ;            % mean of each variable
Xs=X-xbar;                          % mean shift
stdev=(ones(12,1)*std(X'))';
Xs=Xs./stdev;
Ys=(Y-(ones(1,57)*mean(Y'))')./((ones(1,57)*std(Y'))'); % mean shifted data
B=Xs\Ys;                        % regression matrix
% B=(inv(Xs'*Xs))*Xs*Ys;
err=Ys-Xs*B;                      % prediction minus true data
RMSE_ols=sqrt(mean(err.*err));
C1=xbar*(B./std(X)')-(ones(1,57)*mean(Y'))';

%% Part b PCR

Z=[Xs Ys]' ;         % auto scaled data variables x samples
[u s v]=svd(Z);
sdiag = diag(s).*diag(s);         % vector of eigen values
percentvar = zeros(13,1);         % percentage variance explained
for i = 1:13
    percentvar(i) = sum(sdiag(1:i))/sum(sdiag);
end
percentvar  ;
% choosing 2 PCs captures 99 percent of variance, choosing 1 
u1=u(:,1:2);
A=u(:,3:13)';          % Constraint matrix
% last varible is temperature
Aind=A(:,1:12);
Adep=A(:,13);
R=-(inv(Adep'*Adep))*Adep'*Aind;
RMSE_pcr=sqrt(mean((Ys-Xs*R').^2))
C2=xbar*(R'./std(X)')-(ones(1,57)*mean(Y'))';
%% IPCA
[Ahat,lambda]=myIPCA(Z,11,0.00001);
% lambda=lambda.^2
lambda
Aindi=A(:,1:12);
Adepi=A(:,13);
Ri=-(inv(Adepi'*Adepi))*Adepi'*Aindi;
RMSE_ipcr=sqrt(mean((Ys-Xs*Ri').^2))
C3=xbar*(Ri'./std(X)')-(ones(1,57)*mean(Y'))';


