function resetState
% $Id: resetState.m,v 1.1 2003/11/17 12:05:03 mtjspaan Exp $

global problem;

problem.state=ceil((problem.nrStates/2)*rand);
