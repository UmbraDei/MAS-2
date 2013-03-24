function initProblem
% Problem specific initialization function for Tag.
% $Id: initProblem.m,v 1.8 2004/09/20 15:04:08 mtjspaan Exp $

clear global pomdp;
global problem;
global pomdp;

% String describing the problem.
problem.description='Robot tag';

% String used for creating filenames etc.
problem.unixName='tag';

% Use sparse matrix computation.
problem.useSparse=1;

% Load the (cached) .POMDP, defaults to unixName.POMDP.
initPOMDP('tagAvoid.POMDP');

% Generic POMDP initialization code. Should be called after initPOMDP.
initProblemGeneric;

% This allows us to use the default episodeEnded.m.
problem.goodReward=max(problem.rewards);
