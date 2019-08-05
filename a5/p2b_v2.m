clear
clc
load('ncadata.mat')

Z=measabs';
m=3; % no of constraints
[u s v]=svd(Z);
[n N]=size(Z);
u1=u(:,1:N-m);
s1=s(1:N-m,1:N-m);
v1=v(:,1:N-m);
Zhat=u1*s1*v1'; % denoised spectra
Ahat=u(:,N-m+1:N);
% [L4,T] = rotatefactors(Ahat,'method','pattern','target',A');
%% Obtain the connectivity matrix
Ahat1=pureabs'\Zhat

