function [m]=solvem(A1,i,j)
% j is a vector

P=A1(i,j)';
P(:,i)=[];
Q=-A1(i,j)';
m=P\Q;