function initProblem
% $Id: initProblem.m,v 1.6 2003/12/17 13:20:37 mtjspaan Exp $

clear global pomdp;
global problem;
global pomdp;

problem.description='TRC';
problem.unixName='trc';

problem.useSparse=1;

problem.randomSeed=sum(100*clock);
rand('state',problem.randomSeed); % seed the random number generator

initPOMDP;
load trcClusterCenters;
pomdp.MS=MS;
pomdp.MO=MO;

initProblemGeneric;

problem.goodReward=max(max(problem.reward));
