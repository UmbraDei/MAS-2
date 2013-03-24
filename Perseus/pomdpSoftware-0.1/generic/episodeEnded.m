function bool = episodeEnded(r,s1)
% Check whether or not the episode has ended. Should be overriden
% in problem directory if necessary.

% Author: Matthijs Spaan
% $Id: episodeEnded.m,v 1.2 2003/08/25 08:16:33 mtjspaan Exp $
% Copyright (c) 2003,2004 Universiteit van Amsterdam.  All rights reserved.
% More information is in the file named COPYING.

global problem;

if r==problem.goodReward
  bool=1;
else
  bool=0;
end
