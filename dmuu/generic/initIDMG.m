function initIDMG(problemType)

global problem;

switch problemType
 case 'h'
  IDMG=IDMGStruct(1, problem.agentGoals, ...
                  problem.agentStartLocations, [11]);
 case 'isr'
  IDMG=IDMGStruct(5, problem.agentGoals, problem.agentStartLocations, [29 30 ...
                      22 23 16 17 5 6 1 2 8 10 3 12 4 13 18 19 24 ...
                      25 41 36 37 34 40]);
 case 'mit'
  IDMG=IDMGStruct(6, problem.agentGoals, ...
             problem.agentStartLocations, [21 22 ...
                      1 7 2 9 3 11 4 17 5 19 28 29 43 49 41 48 35 ...
                      47 33 46 31 45]);
end
 
[M,Pind,Rind] = buildMMDP(IDMG);

problem.nrActions=M.nA;
problem.nrStates=M.nS;

problem.transition=zeros(problem.nrStates,problem.nrStates, ...
                         problem.nrActions);
for a=1:problem.nrActions
  problem.transition(:,:,a)=M.P{a}';
end
problem.reward=M.r;
problem.gamma=M.gamma;

problem.start=zeros(1,problem.nrStates);
problem.start(M.X0)=1;

problem.rewardInd=Rind;
for k=1:2
  problem.transitionInd{k}=zeros(size(Pind{k}));
  for a=1:sqrt(problem.nrActions)
    problem.transitionInd{k}(:,:,a)=Pind{k}(:,:,a)';
  end
end


