function [out]=impute(a,v)
nvar=max(size(v))    % number of variables
k=[]
 for  i=1:nvar
      if (abs(sign(v(i))))
          k=[k; i]   ;         % find all element having non zero elements
      end
 end
   v=zeros(nvar,1);
   for i=1:max(size(a))
    v(k(i))=a(i);           % impute 
   end
    out=v
 end