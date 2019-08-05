function [A P]=fastNCA(Z,Astruc,p)

clear
clc
load('ncadata.mat')
%%
Astruc=[1 1 0; 1 0 1; 0 1 1; 1 0 1; 1 1 0; 1 0 1; 0 1 1] % 7x3
Z=measabs;              % 7x176
p=3


    Z=Z';
    [p1 q]=size(Astruc);

    [n N]=size(Z);
%% step 1
    [U s V]=svd(Z,'econ');
    U1=U(:,1:p);
    Wstar=U1;
%% step 2
a=[]
for i=1:p1
    [Wc Wr] = rearrange(Wstar, Astruc, i);
    %% step 3, 4
    [u1 s1 v1]=svd(Wr);
    S=v1(:,end);
    %% step 5
    [u2 s2 v2]=svd(Wc*S);
%     a(:,i)=u2(:,1);
end

for i=1:q
    A(:,i)=impute(a(:,i),Astruc(:,i))
end
P=(Z'\A')';

