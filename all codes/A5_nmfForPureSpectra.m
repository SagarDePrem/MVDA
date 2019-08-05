clear ; clc;
load('Inorfull.mat')
[m n]=size(DATA);

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
%% Data selection 

  for i=1:26
%       DATA1(i,:)=DATA3(5*(i-1)+1,:);         % select 1st of each blocks 
        DATA1(i,:)=mean(DATA3([5*i-4:5*i],:)); % select mean of each block 
  end
   
%% Extract pure component spectra

P=[PureCo ; PureCr ; PureNi ]; 
P=[PureCo/PureCoCONC; PureCr/PureCrCONC; PureNi/PureNiCONC]; % normalize by pure concentration

 %% Compute the nmf factors
% H is the pure spectra matrix
% W is the concentration matrix
%  [u s v]=svd(DATA1')
  [W,H,iter,HIS]=nmf(DATA1,3); 
  
 %% calculate correlation matrix
 for i=1:3
     for j=1:3
         p=corrcoef(P(i,:),H(j,:));
         q(i,j)=p(1,2);
     end
 end
 %% plotter
%  i=3
% j=2
% plot(H(i,:)/max(H(i,:)))
% hold on
% plot(P(j,:)/max(P(j,:)))
% % plot(H(2,:)/max(P(2,:)))
% %plot(H(3,:)/max(P(3,:)))
% %legend('Estimated 1st component','Pure compenent of Co','Pure compenent of Cr','Pure compenent of Ni')
% legend('Estimated 1st component','Pure compenent of Cr')
% title('Comparison of 3rd estimated pure component with the known pure components of Co (Scaled to 1)')
% xlabel('Wavelength')
% ylabel('Pure component absorption')
 