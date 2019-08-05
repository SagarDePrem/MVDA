clear ; clc;
load('NcaData1.mat')
[m n]=size(measabs);
DATA=measabs;
%% Remove negative absorbances
DATA3=DATA ;
[m n]=size(DATA);
for i=1:m
     for j=1:n
         if DATA(i,j)<0
             DATA3(i,j)=0;
         end
     end
 end

 %% Compute the nmf factors
% H is the pure spectra matrix
% W is the concentration matrix
 
  [W,H,iter,HIS]=nmf(DATA3,3);