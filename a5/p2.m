clear 
clc
load('NcaData1.mat');
measabs=measabs' ;% M samples *N variables
[M N]=size(measabs);
[N L]=size(A);

%% criterion 1
k=rank(A);
if k==L
    fprintf('Criterion 1 satisfied: A is full column matrix  \n')
else
    fprintf('Error! Criterion 1 not satisfied!\n')
end
%% criterion 2: each column of A must have at least L-1 zeros
for i=1:3
k(i)=N-nnz(A(:,i));
end
if k>=L-1
    fprintf('Criterion 2 satisfied: Each column of A has at least %d-1 zeros\n',L)
end
%% criterion 3
if L<M
    fprintf('Criterion 3 satisfied\n')
end
%% PCA
[u s v]=svd(measabs);
u1=u(:,1:M-3);
s1=s(1:(M-3),1:N-3);
v1=v(:,1:N-3); 
 predabs=u1*s1*v1';
 A1=v(:,N-3+1:N)
 
