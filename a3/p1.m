clear all; close all; clc
load('Inorfull.mat')

for i=1:26
DATA1(i,:)=DATA(5*(i-1)+1,:);         % select 1st of each blocks 
%DATA1(i,:)=mean(DATA([5*i-4:5*i],:));% select mean of each block 
CONC1(i,:)=CONC(5*(i-1)+1,:);         % select 1st of each blocks
end
Z=DATA1';                             % data matrix 176x26
[u,s,v]=svd(Z);                       % svd 
    
for k=1:176
    RMSE(k)=0;
    
    for i=1:26
    s1=s(1:k,:);                      % kx26
    u1=u(:,1:k);                      % 26xk
    T=s1*v';                          % kx26
    T1=T;
    T1(:,i)=[];                       % leave ith score out kx25
       
    conc=CONC1;                         
    conc(i,:)=[] ;                      % leave ith conc out, 25x3
    P=[PureCo/PureCoCONC; PureCr/PureCrCONC; PureNi/PureNiCONC]; 
    Y=(P'*conc')';                         % dependent quantity of OLS regression (176x3)(3x25)=176x25
    B=T1'\Y;                % Regression matrix Y=T1'B 25x176=(25xk)(kx176)
    
    c_p=T(:,i)'*B*P'*inv(P*P');        % predicted concentration
    
    RMSE(k)=RMSE(k)+norm(c_p-CONC1(i,:))^2; 
    
    end
end
RMSE=sqrt(RMSE'/26);
[M,m]=min(RMSE);
fprintf('\n\n--------------------------------------------------------\n')
fprintf('\n Number of PCs is %d \n',m)
fprintf('\n RMSE=%d \n',M)
fprintf('\n--------------------------------------------------------\n')
plot([1:176],RMSE)
xlabel('k (no of PCs)')
ylabel('RMSE')
title('Leave one out Cross validation')