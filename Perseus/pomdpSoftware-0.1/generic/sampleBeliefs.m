function S = sampleBeliefs(n)
% sampleBeliefs - sample beliefs from a POMDP following a random policy
%
% S = sampleBeliefs(n)
%
% n - (1 x 1) number of beliefs to sample
%
% Returns
% S - (n x d) the sampled beliefs
%
% Beliefs are sampled by performing a random walk through the POMDP.

% Author: Matthijs Spaan
% $Id: sampleBeliefs.m,v 1.7 2004/07/14 16:05:21 mtjspaan Exp $
% Copyright (c) 2003,2004 Universiteit van Amsterdam.  All rights reserved.
% More information is in the file named COPYING.

clear global problem;
global problem;

initProblem;

resetBelief;

rand('state',2);
resetState;

lastPrint=0;
start=cputime;

for i=1:n
  saveCurrentBelief;
  a=getRandomAction;
  [s1,b1,o]=getSuccessor(problem.belief,problem.state,a);
  r=getReward(s1,problem.state,a);
  
  printEvent(problem.state,s1,problem.belief,b1,a,o,r,i);
  
  problem.belief=b1;
  problem.state=s1;
  
  if i==lastPrint+1000
    fprintf('%d %f\n',i,cputime-start);
    resetBelief;
    resetState;
    lastPrint=i;
  end

  if episodeEnded(r,s1)
    fprintf('episode ended at %d\n',i);
    resetBelief;
    resetState;
  end
end

S=returnSavedBeliefs;
