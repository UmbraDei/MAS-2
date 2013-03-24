function a = getRandomAction
% getRandomAction - return an action uniformly at random

% Author: Matthijs Spaan
% $Id: getRandomAction.m,v 1.2 2004/07/14 16:05:21 mtjspaan Exp $
% Copyright (c) 2003,2004 Universiteit van Amsterdam.  All rights reserved.
% More information is in the file named COPYING.

global problem;

a=ceil(rand*problem.nrActions);
