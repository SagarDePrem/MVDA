% function [m]=getRotVec(k1,k2, A ,A1)
function [m]=getRotVec(k1,k2,k3,A ,A1)

i=k1(1);
j1=k1(2); j2=k2(2);
j3=k3(2);
r1=A1(:,j1)'; r1(i)=[];
r2=A1(:,j2)';
r2(i)=[];
r3=A1(:,j3)';
r3(i)=[];
% P=[r1 ;r2];
P=[r1 ;r2;r3];
Q=-[A1(i,j1);A1(i,j2);A1(i,j3)];

% Q=-[A1(i,j1);A1(i,j2)];
x=P\Q;
v=x(1:i-1)';
w=x(i:end)';
m=[v 1 w];


