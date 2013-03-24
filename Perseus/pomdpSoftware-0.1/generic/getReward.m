function r = getReward(s1,s,a)
% getReward - return the reward received from the system
%
% r = getReward(s1,s,a)

% Author: Matthijs Spaan
% $Id: getReward.m,v 1.5 2004/09/20 13:07:44 mtjspaan Exp $
% Copyright (c) 2003,2004 Universiteit van Amsterdam.  All rights reserved.
% More information is in the file named COPYING.

global problem;

if problem.useSparseReward
  if problem.useReward3
    r=problem.reward3S{a}(s1,s);
  else
    r=problem.rewardS{a}(s);
  end
else
  if problem.useReward3
    r=problem.reward3(s1,s,a);
  else
    r=problem.reward(s,a);
  end
end
