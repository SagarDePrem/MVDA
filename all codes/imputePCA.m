function [v3]=imputePCA(A,v)
% the problem is treated like a regression problem where the regression
% matrix can be calculated and the nan elements can be treated as dependent
% variables and the rest as independent variables

%% identify independent variables or nan variables 
    k=[];
    v1=v;
    for i=1:max(size(v))
        if isnan(v(i))
            k=[k;i];  
        end
    end
v1(k)=[];           % dependent variable
%% get regression matrix
    P=A; P(:,k)=[];     % Aindependent
    A1=A(:,k);          % Adependent
    B1=-P*v1;           %   Aindependent*Zi+Adependent*Zd=0, Zd=-Adependent\Aindependent*Zi
    V=A1\B1;
%% evaluate the missing terms and impute
    v(k)=V;           % impute
    v3=v;             % return the imputed sample
 end