%    Test the expt. data sets downloaded from Wentzell's site with
%   PCA.  Here the data at different wavelengths is assumed to be the
%    different samples.  Absorbance for 26 different mixture concentrations at 176
%    different wavelengths are taken and each is repeated 5 times to give a
%     data matrix of size 130 x 176 (n x N). Corresponding to each conc. since
%    5 readings are taken at all wavelengths, we compute the average of every
%    5 rows to get a data matrix of size 26 x 176.
clear all;
clc;

load('Inorfull.mat');

%    Compute average of every 5 rows of DATA matrix and store.  To be used
%    with lab data generated experimentally by Wentzell and loaded in his web site.

Ydata = [];
stdavg = [];
concavg = [];

for i=1:26
istart = 5*(i-1)+1;
iend = istart+4;
avg = mean(DATA(istart:iend,:),1);
stda = mean(stdDATA(istart:iend,:),1)/sqrt(5);
Ydata = [Ydata; avg];
stdavg = [stdavg; stda];
avg = mean(CONC(istart:iend,:),1);
concavg = [concavg;avg];
end
absorbances = Ydata;
conc = concavg;
save('data1','absorbances','conc');

%  Generate covariance matrix of errors assuming it does not vary across
% samples
%  Qe = diag(mean(stdavg,1));
%   Generate covariance matrix of errors assuming it does not vary across
%   wavelength

%  Perform test on UV data set used in J. Chemometrics by Wentzell et al. 1997
%    load 'Nirs'  
%    [nrow, ncol] = size(nscal2);
%   Store data in Ydata and covariance matrix in Qe
%    Ydata = nscal2;
%    Qe = diag(nsstd2.*nsstd2);
%  
%  Set the number of PCs to be retained (latent factors)
nfact = 2;
[nsamples, nwave] = size(Ydata);

% Perform PCA to obtain scores matrix
[U S V] = svd(Ydata,'econ');
T = U(:,1:nfact)*S(1:nfact,1:nfact);

%  General code for leave one score out validation
sumsqr = zeros(3,1);
for k = 1:nsamples
%   Compute weighted sum squared error in conc estimates (leave one
%   sample out)
% 
%  Determine the regression matrix relating concn to absorbance leaving
%  out scores of one of the samples.
        concsub = [concavg(1:k-1,:);concavg(k+1:nsamples,:)];  % Average of replicates
        Tsub = [T(1:k-1,:);T(k+1:nsamples,:)];
        B = inv(Tsub'*Tsub)*Tsub'*concsub;

%  compute scores for the left out sample
        tsample = T(k,:);

%  Estimate the concentrations of k'th sample that has been left out
        Concest = tsample*B;

%  determine the sum squared prediction errors in each component and
%  total
    for i = 1:3
            errest = Concest(i) - concavg(k,i);
            sumsqr(i) = sumsqr(i) + errest*errest;
    end
end
RMSE = sqrt(sumsqr/nsamples)
RMSET = sqrt(sum(sumsqr)/(nsamples*3))