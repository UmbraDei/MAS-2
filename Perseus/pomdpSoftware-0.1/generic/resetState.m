function resetState
% resetState - reset the state of a POMDP problem
%
% If a start distribution is present, sample from it, otherwise sample
% uniformly at random from all states.

% Author: Matthijs Spaan
% $Id: resetState.m,v 1.2 2004/07/13 13:59:32 mtjspaan Exp $
% Copyright (c) 2003,2004 Universiteit van Amsterdam.  All rights reserved.
% More information is in the file named COPYING.

global problem;

if isfield(problem,'start')
  problem.state=min(find(problem.startCum>rand));
else
  problem.state=ceil(problem.nrStates*rand);
end
