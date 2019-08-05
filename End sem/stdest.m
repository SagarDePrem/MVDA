function [sd] = stdest(A,Z);
%  function for generating initial estimate of error covariance matrix
%  based on Keller's method (least squares solution)
% INPUTS:
% A : m x n constraint matrix
% Z : data matrix n x N, n rows are variables and N columns are samples.
% Note if a scaled data matrix is provided, then the standard deviation
% estimates of scaled variables are computed by this function. If unscaled
% data matrix is provided, then standard deviation estimates of original
% unscaled variables are computed.  If the model is AZ* = 0, then the data
% should not be mean shifted.  However, if AZ* = b, then mean shift the
% data before passing it to this function.

% OUTPUTS
%  sd : Estimated measurement error standard deviations returned as a
%  vector n x 1
%
[m n] = size(A);
nz = n;
maxnz = m*(m+1)/2;
if ( nz > maxnz )
        disp ('The maximum number of nonzero elements of Qe that can be estimated exceeds limit');
        return
end
% Construct D matrix
G = [];
for j = 1:n
    C = [];
    for i = 1:m
        C = [C; A(i,j)*A(:,j)];
    end
    G = [G, C];
end
% Construct RHS of equation
nsamples = size(Z,2);
R = A*Z;
V = R*R'/nsamples;
vecV = [];
for i = 1:m
    vecV = [vecV; V(:,i)];
end
% Least squares estimate
sd = sqrt(abs((G'*G)\(G'*vecV)));

