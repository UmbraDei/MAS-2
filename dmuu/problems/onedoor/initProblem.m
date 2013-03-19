function initProblem
% $Id: initProblem.m,v 1.5 2003/12/09 17:27:16 mtjspaan Exp $

clear global pomdp;
global problem;
global pomdp;

problem.description='OneDoor';
problem.unixName='onedoor';

problem.randomSeed=sum(100*clock);
rand('state',problem.randomSeed); % seed the random number generator

problem.map=[
1,2,0,12,13;
3,4,0,14,15;
5,6,11,16,17;
7,8,0,18,19;
9,10,0,20,21;
            ];

problem.agentGoals=[13 9];
problem.agentStartLocations=[1 21];

initIDMG('h');
