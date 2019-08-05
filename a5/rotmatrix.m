% function [M]=rotmatrix(A,A1)
[m n]=size(A);
k=[];
for i=1:m
    for j=1:n
     if A(i,j)==0
         k=[k; i j];
     end
    end
end
 j=1;
% for i=1:m
%     M(1,:)=getRotVec(k(j,:),k(j+1,:),A,A1);
%      j=j+m-1;
% end
 M5(2,:)=getRotVec(k(3,:),k(4+1,:),k(5,:),A,A1);
%  j=j+m;
%  M(3,:)=getRotVec(k(j,:),k(j+1,:),A,A1);


