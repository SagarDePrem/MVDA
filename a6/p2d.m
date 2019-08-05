
load('arx.mat')
%%
u=fliplr(umeas);
y=fliplr(ymeas);
u1=u(2:1000)';

%for p=1:1000
%% Construct the data matrix
m=10;
Z=[];
for i=1:1000-m
    y1=fliplr(y(i:i+m))';
    u1=fliplr(y(i+1:i+m))';
    X=[y1;u1];
    Z=[Z X];
    
end
%% PCA

[U S V]=svd(Z);
Ahat=U(:,2*m+1-10+1:2*m+1)';
Ahat1=Ahat(:,1:11);
Bhat=Ahat(:,12:21);
K=diag(ones(10,1));
K1=[K zeros(10,1)];
K2=[zeros(10,1) K];
Astruc1=[K1+K2 K];
Astruc=[K1+K2];
[Atrue,R] = rotatefactors(Ahat','method','pattern','target',Astruc1');
[Atrue1,R2] = rotatefactors(Ahat1','method','pattern','target',Astruc');

% Atrue=Atrue';
%% Normalize R by diagonal elements
R1=R;

for i=1:10
    R1(:,i)=R1(:,i)/R(i,i);
    
end
Atrue=(Ahat1'*R1)';

%% model coefficients
j=1;
for i=1:10
    a=Atrue(i,j);
    j=j+1;
end
a=a/10;
j=2;
for i=1:10
    b=Atrue(i,j);
    j=j+1;
end
b=b/10;

Btrue=(Bhat'*R1)';
c=trace(Btrue)/10;

a0=-b/a
b0=c/a
 