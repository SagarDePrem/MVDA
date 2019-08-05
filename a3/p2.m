clear all;
clc;
load('flowdata2.mat')

Fmeas=Fmeas-(ones(1000,1)*mean(Fmeas)) ;     % mean shift
Fmeas=Fmeas./(ones(1000,1)*std');
Ftrue=Ftrue-(ones(1000,1)*mean(Ftrue)) ;     % mean shift
Ftrue=Ftrue./(ones(1000,1)*std');
Z1 = Fmeas'*Fmeas;                   % covariance matrix of measurements
Z2 = Ftrue'*Ftrue;                   % covariance matrix of true values
[A1,D1]=eig(Z1);                     % get eigen value matrix and eigen vector matrix
[A2,D2]=eig(Z2);
V1=(A1(:,[1:3]))';                   % Choosing 3 PCs to get the model
V2=(A2(:,[1:3]))';
Bmeas=-inv(V1(:,[3,4,5]))*V1(:,[1,2])   % Obtain the regression matrix
Btrue=-inv(V2(:,[3,4,5]))*V2(:,[1,2])