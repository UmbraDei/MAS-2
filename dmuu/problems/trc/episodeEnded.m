function bool = episodeEnded(r,s1)
% $Id: episodeEnded.m,v 1.3 2003/12/04 17:03:17 mtjspaan Exp $

global problem;

if abs(r-problem.goodReward)<1e-6
  bool=1;
else
  bool=0;
end
