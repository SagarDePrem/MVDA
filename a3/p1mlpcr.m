clear all; close all; clc
load('Inorfull.mat')
%% select data
for i=1:26
% DATA1(i,:)=DATA(5*(i-1)+1,:);         % select 1st of each blocks 
DATA1(i,:)=mean(DATA([5*i-4:5*i],:)); % select mean of each block 
CONC1(i,:)=CONC(5*(i-1)+1,:);         % select 1st of each blocks
end
Z=DATA1';                             % data matrix 176x26
Z=Z./(ones(26,1)*std(Z'))'          % scale MLPCA
% CONC1=CONC1';                           % concentration matrix 3*26
%% Perform svd
[u,s,v]=svd(Z);                       % svd 
%% twin loop for  k pcs and ith sample left out
rmse=[];
for k=1:8%rank(s)                     % maximum number of PCs is the rank of the singular value matrix
% k=1   
RMSE=[];                      % set RMSE zero for k choice of PC
    
    for i=1:26
    s1=s(1:k,1:k);                      % kx26
    u1=u(:,1:k);                      % 26xk
    v1=v(:,1:k);                        % 26xk
    T=s1*v1';                          % kx26 scores
    T1=T;
    T1(:,i)=[];                       % leave ith score out kx25
       
    conc=CONC1;                         
    conc(i,:)=[] ;                      % leave ith conc out, 25x3

    B=T1'\conc;
    c_p=T(:,i)'*B;
    
    RMSE=[RMSE; c_p-CONC1(i,:)]; 
    
    end
    RMSE=(mean(RMSE.^2)).^0.5;
    rmse=[rmse; RMSE]
  end
plot(mean(rmse'))
% RMSE=sqrt(RMSE'/26);
% [M,m]=min(RMSE);
% %% Print output 
% fprintf('\n\n--------------------------------------------------------\n')
% fprintf('\n Number of PCs is %d \n',m)
% fprintf('\n RMSE=%d \n',M)
% fprintf('\n--------------------------------------------------------\n')
% plot(RMSE)
% xlabel('k (no of PCs)')
% ylabel('RMSE')
% title('Leave one out Cross validation')