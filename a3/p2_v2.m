clear all;
clc;
load('flowdata2.mat')
%std1=[1.0046047241	2.0083865725	2.2295373235	2.2168394201	1.0186894147];
%Fmeas=Fmeas-(ones(1000,1)*mean(Fmeas)) ;     % mean shift
%Fmeas=Fmeas./(ones(1000,1)*std');
Ftrue=Ftrue-(ones(1000,1)*mean(Ftrue)) ;     % mean shift
Ftrue=Ftrue./(ones(1000,1)*std');
Z=Fmeas';
%Z=Ftrue';
[u,s,v]=svd(Z);
k=3;
s1=s(1:k,:);                      
u1=(u(:,1:k))';                 
T=(s1*v');
B=-inv(u1(:,[3,4,5]))*u1(:,[1,2]) 

