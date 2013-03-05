function initProblem
% $Id: initProblem.m,v 1.5 2003/12/09 17:27:16 mtjspaan Exp $

clear global pomdp;
global problem;
global pomdp;

problem.description='Hallway';
problem.unixName='hallway';

problem.randomSeed=sum(100*clock);
rand('state',problem.randomSeed); % seed the random number generator

initPOMDP;

problem.actions=char('Stay in place','Move forward','Turn right',['Turn ' ...
                    'around'],'Turn left');

problem.stepReward=0;

initProblemGeneric;
%problem.gamma=0.99;

