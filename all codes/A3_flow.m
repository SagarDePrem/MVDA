clear
clc
load('flowdata2.mat');
Z = Fmeas';                         % Z is the data matrix with nVariables x Nsamples
scale_factor = std';                % scale with the error standard deviation given
% scale_factor= [1 1 1 1 1];              % if data is not to be scaled
%% Scaling and mean shifting 
[nvar nsamples] = size(Z);                  % get size of the data matrix 
Zs=Z-(ones(nsamples,1)*mean(Z'))';          % mean shift data
Zs=Zs./(ones(nsamples,1)*scale_factor)';    % scale the data

%% Estimate number of PCs to retain using Percentage variance explained
[U S V] = svd(Zs);                  % SVD
S1 = S(1:nvar,1:nvar);              % the diagonal matrix of singular values
sdiag = diag(S1).*diag(S1);         % vector of eigen values
percentvar = zeros(nvar,1);         % percentage variance explained
for i = 1:nvar
    percentvar(i) = sum(sdiag(1:i))/sum(sdiag);
end
percentvar                  % print percentage variance for user to select number of PCs

%% SCREE Plot to determine optimal PCs
plot(log(diag(S).^2))
grid on
xlabel('Number of PCs')
ylabel('log(\lambda)')
title('SCREE Plot')
 
%% Demonstrate the use of data compression/denoising.  Valid only for uniform scaling
% use either SCREE plot or percentage variance explained
nPC = input('Please enter the number of PCs to retain \n');
% based on Scree Plot.  PCs are U1'z
U1 = U(:,1:nPC);            % Eigenvectors of covariance matrix corresponding to first nPC eigenvalues
T = U1'*Zs;                 % Scores correspondng to the retained PCs
Zhat = U1*T;                % Denoised estimates scaled
Zhat = (ones(nsamples,1)*scale_factor)'.*Zhat; % Denoised estimates unscaled
Ahat=U(:,nvar-2:nvar)';     % estimated contraint matrix 

%% Choose the dependent and independent variables and obtain regression matrix and compare

% choosing F1 and F2 as independent
% this Rhat is calculated in the unscaled form since Rtrue is unscaled
Rhat=-inv(Ahat(:,3:5)./(ones(3,1)*scale_factor(3:5)))*(Ahat(:,1:2).*(ones(3,1)/scale_factor(1:2)))   

% true regression matrix
Rtrue=-inv(Atrue(:,3:5))*Atrue(:,1:2)  

%% Determine how well the model matches with the true constraint matrix.
% For this determine the minimum distance of each true constraint vector from the
% row space of model constraints
for i = 1:3
    bcol = Atrue(i,:)';
    dist_pca(i) = norm(bcol - Ahat'*inv(Ahat*Ahat')*Ahat*bcol);
end

%% Demonstrate model identification, Valid for uniform scaling
Ahat = U(:,nPC+1:end)';
% pause
% Compare Atrue and Ahat with subspace angles, smaller the angle, they are
% linearly dependent
theta_pca = 180*subspace(Atrue', Ahat')/pi;
%% SCREE Plot to determine optimal PCs
plot(log(diag(S).^2))
grid on
xlabel('Number of PCs')
ylabel('log(\lambda)')
title('SCREE Plot')
%%
fprintf('-----------------------------------------------------------------------------------------------------\n' )
fprintf('The maximum absolute differnce between true and estimated Regeression matrix is %d\n\n', max(max(abs(Rhat-Rtrue))))
fprintf('The subspace angle between measured and estimated constraints is %d\n', theta_pca)
fprintf('-----------------------------------------------------------------------------------------------------\n' )
%% Best choice of independent variables
% choose different independent variables and find the condition number,
% lowest is the best
Rtrue=-inv(Atrue(:,[3,4,5]))*Atrue(:,[1,2]);
cond(Rtrue)