function resetBelief
% resetBelief - reset the belief of a POMDP problem
%
% If a start distribution is present, use it, otherwise set the belief
% to the uniform distribution.

% Author: Matthijs Spaan
% $Id: resetBelief.m,v 1.2 2004/07/13 13:59:32 mtjspaan Exp $
% Copyright (c) 2003,2004 Universiteit van Amsterdam.  All rights reserved.
% More information is in the file named COPYING.

global problem;

if isfield(problem,'start');
  problem.belief=problem.start;
else
  problem.belief=repmat(1/problem.nrStates,1,problem.nrStates);
end
