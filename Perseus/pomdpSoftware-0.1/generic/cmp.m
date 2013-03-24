function r = cmp(A,B,epsilon)
% cmp - compare two matrices of the same size.
%
% r = cmp(A,B,epsilon)
%
% A,B     - two matrices of equal size
% epsilon - the tolerance, defaults to 1e-14
% Returns 1 if they are different and 0 otherwise.
%
% Matrices are considered equal if none of their elements differ
% more than epsilon.
%
% $Id: cmp.m,v 1.3 2003/06/30 09:11:48 mtjspaan Exp $

if nargin<3
  epsilon=1e-14;
end

sizeA=size(A);
sizeB=size(B);

if sizeA~=sizeB
  error('cmp: Input matrices are of different size');
end

if abs(min(A-B))<epsilon & abs(max(A-B))<epsilon
  r=0;
else
  r=1;
end
