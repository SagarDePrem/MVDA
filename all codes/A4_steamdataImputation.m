clear all; clc;
load('steamdatamiss.mat')

%% inputs

Y=Fmeas;
nind=17;
m=12;                                   % number of constraints
[nvar nsamples]=size(Y);
Rtrue=-Atrue(:,nind+1:nvar)\Atrue(:,1:nind);       % true regression matrix
% set tolerance to last argument of myIPCA wherever used

%% eliminate samples with missing data

Ynew=Y;
k=[];
    for j=1:nsamples  
        for  i=1:nvar
            if isnan(Ynew(i,j))
          k=[k; i j]   ;         % keep track which element is Nan
            end
        end
    end
 k1=k(:,2)';                     % columns to be removed
 Ynew(:,k1)=[];                  % uncorrupted unscaled data matrix
 Ymean=(mean(Ynew'))';           % variable mean for all samples
 
 %% Constraint model using PCA on autoscaled uncorrupted data
 
 fprintf('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n')
 fprintf(' Constraint model using PCA on autoscaled uncorrupted data...\n')
%      [Rhat1,Ahat1,err0,s1]=myPCA(Rtrue,Ynew,std,m,nind);
%       fprintf('Max error with PCA on autoscaled data = %s\n',err0)
   
    [Rhat1,Ahat1,err0,s1]=myIPCA(Rtrue,Ynew,std,m,nind,0.005);
     fprintf('Max error with IPCA on autoscaled data = %s\n',err0)

   %% Imputation using mean
   
   Y2=Y;
   % impute mean to the k1 columns with Nan
   
    for i=1:max(size(k1))
        Y2(:,k1(i))=imputeMean(Ymean,Y(:,k1(i)));     % impute mean to the k(i)th column
    end
   %% 
fprintf('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n')
fprintf('PCA on mean imputed data...\n')
%     [Rhat2,Ahat2,err2,s2]=myPCA(Rtrue,Y2,std,m,nind); 
       [Rhat2,Ahat2,err2,s2]=myIPCA(Rtrue,Y2,std,m,nind,0.005); 
fprintf('Max error with mean imputed data = %s\n',err2)
 
%% iterate
fprintf('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n')
fprintf('Data matrix iteratively imputed by PCA... \n')
    AHat=Ahat2;
    err=s2;
    s=s2; i=0;
    err1=1.5*err2;
       while err >0.0000000001
            err=err1;
            YNew=imputePCA1(AHat,Y,k1);
%           [RHat,AHat,err1,s]=myPCA(Rtrue,YNew,std,m,nind);
%           fprintf('Max error with iteration %d PCA imputed data = %s\n',i,err1)
            [RHat,AHat,err1,s]=myIPCA(Rtrue,YNew,std,m,nind,0.005);
            fprintf('Max error with iteration %d IPCA imputed data = %s\n',i,err1)
            fprintf('~~~~~~~~~~~~~~~~~~~~~~~\n')
            err=err-err1;
            i=i+1;
       end
   
 fprintf('Yo! Solution has converged!!\n')
 fprintf('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n')
     
   
    
  
 
 
 
 
 