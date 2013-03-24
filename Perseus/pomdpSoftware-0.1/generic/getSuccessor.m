function [s1,b1,o] = getSuccessor(b,s,a)
% getSuccessor - get successor state, belief and observation
%
% [s1,b1,o] = getSuccessor(b,s,a)
%
% b - (1 x d) belief at time t
% s - (1 x 1) state at time t
% a - (1 x 1) action taken at time t
%
% Returns
% s1 - (1 x 1) state at time t+1
% b1 - (1 x d) belief at time t+1
% o  - (1 x 1) observation received

% Author: Matthijs Spaan
% $Id: getSuccessor.m,v 1.9 2004/09/03 12:26:36 mtjspaan Exp $
% Copyright (c) 2003,2004 Universiteit van Amsterdam.  All rights reserved.
% More information is in the file named COPYING.

global problem;

if isempty(s)
  s=min(find(cumsum(b)>rand));
end

if problem.useSparse
  u=rand;
  t=0;
  for i=find(problem.transitionS{a}(:,s))'
    t=t+problem.transitionS{a}(i,s);
    if u<=t
      s1=i;
      break;
    end
  end
  if problem.useSparseObs
    u=rand;
    t=0;
    for i=find(problem.observationS{a}(s1,:))
      t=t+problem.observationS{a}(s1,i);
      if u<=t
        o=i;
        break;
      end
    end
  else
    o=min(find(problem.observationCum{a}(s1,:)>rand));
  end

  b1=problem.transitionS{a}*b';
  if problem.useSparseObs
    b1=problem.observationS{a}(:,o).*b1;
  else
    b1=problem.observation{a}(:,o).*b1;
  end
else
  s1=min(find(problem.transitionCum(:,s,a)>rand));
  o=min(find(problem.observationCum(s1,a,:)>rand));
  b1=problem.transition(:,:,a)*b';
  b1=problem.observation(:,a,o).*b1;
end

b1=b1./sum(b1);
b1=b1';
