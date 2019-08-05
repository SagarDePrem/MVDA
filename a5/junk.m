clear all; close all; clc
load('Inorfull.mat')

for i=1:26
% DATA1(i,:)=DATA(5*(i-1)+1,:);         % select 1st of each blocks 
DATA1(i,:)=mean(DATA([5*i-4:5*i],:)); % select mean of each block 
CONC1(i,:)=CONC(5*(i-1)+1,:);         % select 1st of each blocks
end
Z=DATA1';                             % data matrix 176x26
[u,s,v]=svd(Z);                       % svd 
    
for k=1:26
    RMSE(k)=0;
    
    for i=1:26
    s1=s(1:k,:);                      % kx26
    u1=u(:,1:k);                      % 26xk
    T=s1*v';                          % kx26
    T1=T;
    T1(:,i)=[];                       % leave ith score out kx25
       
    conc=CONC1;                         
    conc(i,:)=[] ;                      % leave ith conc out, 25x3
%     P=[PureCo/PureCoCONC; PureCr/PureCrCONC; PureNi/PureNiCONC]; 
    P=[PureCo ; PureCr ; PureNi ]; 
    Y=(P'*conc')';                         % dependent quantity of OLS regression (176x3)(3x25)=176x25
    B=T1'\Y;                % Regression matrix Y=T1'B 25x176=(25xk)(kx176)
    
    c_p=T(:,i)'*B*P'*inv(P*P');        % predicted concentration
    
    RMSE(k)=RMSE(k)+norm(c_p-CONC1(i,:))^2; 
    
    end
end 
DATA2=DATA1;
[m n]=size(DATA1);
for i=1:m
     for j=1:n
         if DATA1(i,j)<0
             DATA2(i,j)=0;
         end
     end
 end

[W,H,iter,HIS]=nmf(DATA1,3);
RMSE=sqrt(RMSE'/26);
[M,m]=min(RMSE);
% [pval, corr_obs, crit_corr, est_alpha, seed_state]=mult_comp_perm_corr(P',H')
% fprintf('\n\n--------------------------------------------------------\n')
% fprintf('\n Number of PCs is %d \n',m)
% fprintf('\n RMSE=%d \n',M)
% fprintf('\n--------------------------------------------------------\n')
% plot(RMSE)
% xlabel('k (no of PCs)')
% ylabel('RMSE')
% title('Leave one out Cross validation')