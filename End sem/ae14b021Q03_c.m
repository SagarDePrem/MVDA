%% Part C
clear
clc
load('arx.mat')
%% 
u=fliplr(umeas);        
y=fliplr(ymeas);
u1=u(2:1000)';
p=1;            % first order

%% Construct the input matrix A

for i=1:999
        if i+p<1000
        A(i,:)=y(i+1:i+p);  
        end
        if i+p>=1000
        A(i,:)=[y(i+1:1000) zeros(1,i+p-1000)];  
        end 
      end
A=[A u1];
A=[y(1:999)' A];
B=[0.0292 0.0292 0; 0.0292 0.0292 0;0 0 0];
%% 
eig(A*A',B)

