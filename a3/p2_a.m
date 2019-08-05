clear all;
clc;
load('flowdata2.mat')
Z1 = Fmeas'*Fmeas;          % covariance matrix of measurements
Z2 = Ftrue'*Ftrue;          % covariance matrix of true values
[A1,D1]=eig(Z1);            % get eigen value matrix and eigen vector matrix
[A2,D2]=eig(Z2);
V1=(A1(:,[1:3]))';          % Choosing 3 PCs to get the model
V2=(A2(:,[1:3]))';
B1=-inv(V1(:,[3,4,5]))*V1(:,[1,2]) ;  % Obtain the regression matrix
B2=-inv(V2(:,[3,4,5]))*V2(:,[1,2]);

%for i=1:size(D1)
 %   d1(i)=sqrt(D1(i,i))
  %  d2(i)=sqrt(D2(i,i))
% end

%plot([1:size(D2)],d2,'1')
%plot([1:size(D1)],d1)

