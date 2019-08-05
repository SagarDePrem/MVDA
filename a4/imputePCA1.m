function [Y1]=imputePCA1(A,Y,k1)
    
    Ynew=Y;
    for i=1:max(size(k1))
        % impute values to the k1 columns containing nan
        Ynew(:,k1(i))=imputePCA(A,Y(:,k1(i)));
    end
    Y1=Ynew;
    
end