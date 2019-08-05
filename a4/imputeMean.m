function [out]=imputeMean1(Ymean,v)
% inputs:
%   Ymean - mean of the variables
%   v     - vector containig nan
% output:
%   out   - mean imputed vectro

nvar=max(size(v));      % number of variables
k=[];
 for  i=1:nvar
      if isnan(v(i))
          k=[k; i]   ;         % find all element having Nan
      end
 end
   
    v(k)=Ymean(k);           % impute 
    out=v;
 end