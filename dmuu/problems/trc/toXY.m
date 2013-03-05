function [x,y] = toXY(s)
% $Id: toXY.m,v 1.2 2003/11/12 12:22:23 mtjspaan Exp $

global problem;

if s>problem.nrStates/2
  s=s-problem.nrStates/2;
end

x=problem.MS(s,1);
y=problem.MS(s,2);
