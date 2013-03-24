function saveCurrentBelief
% saveCurrentBelief - utility function for sampleBeliefs.m

% Author: Matthijs Spaan
% $Id: saveCurrentBelief.m,v 1.3 2004/07/14 16:05:21 mtjspaan Exp $
% Copyright (c) 2003,2004 Universiteit van Amsterdam.  All rights reserved.
% More information is in the file named COPYING.

global problem;

if problem.useSparse
  [n,foo]=size(problem.beliefsSP);
  while problem.nnzBeliefs>=(n-problem.nrStates) % it's almost full,
                                                 % realloc
    n=n*2;
    B=problem.beliefsSP;
    problem.beliefsSP=zeros(n,3);
    problem.beliefsSP(1:problem.nnzBeliefs,:)=B(1:problem.nnzBeliefs,:);
  end
  problem.nrBeliefs=problem.nrBeliefs+1;
  [I,J,S]=find(problem.belief);
  sz=size(I);
  I=repmat(problem.nrBeliefs,sz);
  bottom=problem.nnzBeliefs+1;
  top=bottom+sz(2)-1;
  
  problem.beliefsSP(bottom:top,1)=I';
  problem.beliefsSP(bottom:top,2)=J';
  problem.beliefsSP(bottom:top,3)=S';
 
  problem.nnzBeliefs=top;
else
  [n,d]=size(problem.beliefs);
  if problem.nrBeliefs==n % it's full, realloc
    B=problem.beliefs;
    problem.beliefs=zeros(n*2,problem.nrStates);
    problem.beliefs(1:problem.nrBeliefs,:)=B(1: problem.nrBeliefs,:);
  end
  problem.nrBeliefs=problem.nrBeliefs+1;
  problem.beliefs(problem.nrBeliefs,:)=problem.belief;
end
