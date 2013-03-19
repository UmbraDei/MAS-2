function initProblem
% $Id: initProblem.m,v 1.5 2003/12/09 17:27:16 mtjspaan Exp $

clear global pomdp;
global problem;
global pomdp;

problem.description='ISR';
problem.unixName='isr';

problem.map=[
0,0,29,0,22,0,16,0,5,0;
0,0,30,26,23,20,17,14,6,1;
42,38,31,0,0,0,0,0,7,0;
43,39,32,27,0,0,0,0,8,2;
0,0,33,0,0,0,0,0,9,0;
0,40,34,0,0,0,0,0,10,3;
0,0,35,0,0,0,0,0,11,0;
0,41,36,28,24,21,18,15,12,4;
0,0,37,0,25,0,19,0,13,0;
];

problem.agentGoals=[29 27];
problem.agentStartLocations=[13 4];

[problem.mapInvalidX,problem.mapInvalidY]=find(problem.map==0);

problem.randomSeed=sum(100*clock);
rand('state',problem.randomSeed); % seed the random number generator

initIDMG(problem.unixName);

