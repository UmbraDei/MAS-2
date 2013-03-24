function [x0,x1] = split(x,nrX1)
% split - split an integer in two components
%
% [x0,x1] = split(x,nrX1)
%
% x    - integer obtained from combine.m
% nrX1 - maximum value of x1
%
% returns
% [x0,x1] - integers, unique decomposition of x
%
% This is the inverse operation of combine.m
%
% $Id: split.m,v 1.2 2003/07/31 13:55:21 mtjspaan Exp $

x=x+(nrX1-1);
x0=floor(x/nrX1);
x1=x+1-x0*nrX1;

if x1>nrX1
  error(sprintf('x1=%d is larger than nrX1=%d.',x1,nrX1));
end
