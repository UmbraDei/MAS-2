function alpha = newAlpha(n,d)
% newAlpha - returns a (array of) new alpha vector(s)
%
% alpha = newAlpha(n,d)
%
% n - desired number of vectors, defaults to 1
% d - desired dimensionality, defaults to number of states in the
%     current problem
%
% Returns a struct array of alpha vectors.

% Author: Matthijs Spaan
% $Id: newAlpha.m,v 1.1 2004/07/14 14:23:22 mtjspaan Exp $
% Copyright (c) 2003,2004 Universiteit van Amsterdam.  All rights reserved.
% More information is in the file named COPYING.

if nargin<2
  global problem;
  d=problem.nrStates;
end

if nargin<1
  n=1;
end

alpha=repmat(struct('v',zeros(1,d),'a',0),n,1);
