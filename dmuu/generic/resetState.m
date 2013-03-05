function resetState
% resetState - reset the state of a POMDP problem
%
% If a start distribution is present, sample from it, otherwise sample
% uniformly at random from all states.

% $Id: resetState.m,v 1.9 2005/10/05 15:43:46 matthijs Exp $

global problem;

if isfield(problem,'start')
  problem.state=min(find(problem.startCum>rand));
else
  problem.state=ceil(problem.nrStates*rand);
end
