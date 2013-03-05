function resetBelief
% resetBelief - reset the belief of a POMDP problem
%
% If a start distribution is present, use it, otherwise set the belief
% to the uniform distribution.

% $Id: resetBelief.m,v 1.6 2005/08/09 17:48:46 matthijs Exp $

global problem;

if isfield(problem,'start');
  problem.belief=problem.start;
else
  problem.belief=repmat(1/problem.nrStates,1,problem.nrStates);
end
