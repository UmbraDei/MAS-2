function initProblem
% $Id: initProblem.m,v 1.5 2003/12/09 17:27:16 mtjspaan Exp $

clear global pomdp;
global problem;
global pomdp;

problem.description='MIT';
problem.unixName='mit';

problem.map=[
0,0,1,0,2,0,3,0,0,0,0,0,4,0,5,0,0;
0,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,0;
21,22,0,23,0,0,0,24,25,26,27,0,0,0,0,28,29;
0,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,0;
0,0,45,0,46,0,47,0,0,0,0,0,48,0,49,0,0;
            ];

problem.agentGoals=[21 29];
problem.agentStartLocations=[29 21];

initIDMG(problem.unixName);

problem.randomSeed=sum(100*clock);
rand('state',problem.randomSeed); % seed the random number generator
