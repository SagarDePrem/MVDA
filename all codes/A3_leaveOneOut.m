% This code performs the Leave one out cross validation to obtain the
% number of optimal choice of PCs

clear all; close all; clc
load('Inorfull.mat')
 
%% select data
for i=1:26
    % DATA1(i,:)=DATA(5*(i-1)+1,:);             % select 1st of each blocks 
    DATA1(i,:)=mean(DATA([5*i-4:5*i],:));       % select mean of each block 
    CONC1(i,:)=CONC(5*(i-1)+1,:);               % select 1st of each blocks
end
    Z=DATA1';                                   % data matrix 176x26
    
    %%

for i=1:26
stdData(:,i)=std(DATA([5*i-4:5*i],:));      % std of errors
end
% stdData=ones(26,1)*mean(stdData);
    Z=Z./stdData;                  % scale if MLPCA, comment if scaling is not needed
    
%% Perform svd
    [u,s,v]=svd(Z);                             % svd 
    
%% twin loop for  k pcs and ith sample left out
    rmse=[];
for k=1:rank(s)                           % maximum number of PCs is the rank of the singular value matrix
    difference=[];                                    % set RMSE zero for k choice of PC
    
    for i=1:26
        s1=s(1:k,1:k);                          % kx26
        u1=u(:,1:k);                            % 26xk
        v1=v(:,1:k);                            % 26xk
        T=s1*v1';                               % kx26 scores
        T1=T;
        T1(:,i)=[];                             % leave ith score out kx25
        conc=CONC1;                         
        conc(i,:)=[] ;                          % leave ith conc out, 25x3
        B=T1'\conc;                             % obtain regression matrix such that conc=scores*B
        c_p=T(:,i)'*B;                          % predict concentration
        difference=[difference; c_p-CONC1(i,:)]; % difference in concentrations between predicted and known conentrations
    end
    difference=(mean(difference.^2)).^0.5;    % RMSE for the 3 species for k choice of PCs
    rmse=[rmse; difference];                  % stack
end
Rmse=(mean(rmse'.^2)).^0.5;
plot(Rmse)
fprintf('--------------------------------------------------\n')
fprintf('RMSE for each choice of PC starting from 1 to %d for species Co,Cr and Ni\n',rank(s))
rmse
fprintf('--------------------------------------------------\n')
