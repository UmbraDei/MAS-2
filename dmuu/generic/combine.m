function x = combine(x0,x1,nrX1)
% combine - maps two integers to an unique integer
%
% x = combine(x0,x1,nrX1)
%
% x0, x1 - integers
% nrX1   - maximum value of x1
%
% returns
% x - a unique combination of x0 and x1
%
% See split.m for the inverse operation.
%
% $Id: combine.m,v 1.2 2003/07/31 13:55:21 mtjspaan Exp $

if x1>nrX1
  error(sprintf('x1=%d is larger than nrX1=%d.',x1,nrX1));
else
  x=x0*nrX1+(x1-1)-(nrX1-1);
end
