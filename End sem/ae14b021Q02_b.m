clear
clc
load('ncadata.mat')
%%
Astruc=[1 1 0; 1 0 1; 0 1 1; 1 0 1; 1 1 0; 1 0 1; 0 1 1] % 7x3
Z=measabs;              % 7x176
p=3                     % pure species
% [A P]=fastNCA(Z,Astruc,p);

Astruc=[-.1804 -.1597 0;...
        0.4178 0 0.4414;...
        0 -0.0225 .1816;...
        0.5849 0 0.77861;...
         0.2513 -0.6071 0;...
           -.6225 0 -0.2208;...
            0 -0.7781 -0.3425]
P=(Z\Astruc)'
%% True structure of A with correct non zero values is A

P           % P is the estimated pure component spectra
k=corrcoef(P,pureabs);
k(1,2)      % correlation coefficient for the pure and estimated pure spectra