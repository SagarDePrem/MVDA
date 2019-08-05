
%   function [m]=kpcr(width,kmax)
  
%% Applying KPCA for vapour pressure data
load vpdata
clear std
ttrain = temp(1:70);
ptrain = psat(1:70);
ttest = temp(71:100);
ptest = psat(71:100);

%%  Shift and scale x data

tmean = mean(ttrain);
tstd = std(ttrain);
xs = (ttrain - tmean*ones(size(ttrain)))/tstd;
nsamples = length(ttrain);

%% Compute Kernel matrix using Gaussian kernel

K = zeros(nsamples,nsamples);
% prompt = 'Enter a value for width \n ';
width= 4.9627;%input(prompt);
for i = 1:nsamples
    for j = i:nsamples
        diff = xs(i)-xs(j);
        K(i,j) = exp(-diff*diff/width);
        K(j,i) = K(i,j);
    end
end
%% Apply PCA to K.  Use PCs for building the regression model
[V D] = eig(K);
% plot(log(sort(diag(D))))
%%  Choose different number of PCs and determine PRESS on test set

for k = 1:5
    nfact = nsamples-k+1;
    sval = diag(D);
    lamda = sval(nfact:nsamples);
    Pc = V(:,nfact:nsamples);
    % regression matrix
    B = K*Pc*diag(lamda.^(-0.5));
    w = inv(B'*B)*B'*ptrain;
    %% Estimate pressures using KPCR model for test data
    ntest = length(ttest);
    Ktest = zeros(ntest,nsamples);
    xtest = (ttest - tmean*ones(size(ttest)))/tstd;
    for i = 1:ntest
        for j = 1:nsamples
            diff = xtest(i) - xs(j);
            Ktest(i,j) = exp(-diff*diff/width);
        end
    end
    psatest = Ktest*Pc*diag(lamda.^(-0.5))*w;
    error(k) = norm(ptest-psatest);
    %     psatest =  B*w;
    %     error = (psat-psatest)'*(psat-psatest);
    %     %  Compute AIC criteria
    %     AIC(k) = 2*k - 2*error + 2*k*(k+1)/(nsamples-k+1);
end
[m n]=min(error);
fprintf('\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n')
fprintf('The least error is %d with %d PCs\n',m,n)
fprintf('\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n')

%%  Predict saturation pressure for temp = 55 deg C (interpolation)
xtest = (55 - tmean)/tstd;
for i = 1:nsamples
    diff = xtest - xs(i);
    kvec(i) = exp(-diff*diff/width);
end
psathat = kvec*Pc*diag(lamda.^(-0.5))*w;
psattrue = exp(14.0568-2825.42/(55+230.44));
 fprintf('Saturated pressure for 55deg: \n Estimated: %d \n True: %d\n',psathat,psattrue)
fprintf('\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n')

%%  Predict saturation pressure for temp = 55 deg C (interpolation)
xtest = (100 - tmean)/tstd;
for i = 1:nsamples
    diff = xtest - xs(i);
    kvec(i) = exp(-diff*diff/width);
end
psathat = kvec*Pc*diag(lamda.^(-0.5))*w;
psattrue = exp(14.0568-2825.42/(100+230.44));
 fprintf('Saturated pressure for 100deg: \n Estimated: %d \n True: %d\n',psathat,psattrue)
fprintf('\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n')
% end
