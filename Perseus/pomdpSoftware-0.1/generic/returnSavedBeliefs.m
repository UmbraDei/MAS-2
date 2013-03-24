function S = returnSavedBeliefs
% returnSavedBeliefs - utility function for sampleBeliefs.m

% Author: Matthijs Spaan
% $Id: returnSavedBeliefs.m,v 1.2 2004/07/14 16:05:21 mtjspaan Exp $
% Copyright (c) 2003,2004 Universiteit van Amsterdam.  All rights reserved.
% More information is in the file named COPYING.

global problem;

if problem.useSparse
  S=sparse(problem.beliefsSP(1:problem.nnzBeliefs,1), ...
           problem.beliefsSP(1:problem.nnzBeliefs,2), ...
           problem.beliefsSP(1:problem.nnzBeliefs,3), ...
           problem.nrBeliefs, ...
           problem.nrStates);
  fprintf('Density is %f\n',nnz(S)/prod(size(S)));
else
  S=problem.beliefs(1:problem.nrBeliefs,:);
end

