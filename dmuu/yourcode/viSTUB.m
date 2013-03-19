function Q = vi

clear global problem;
initProblem;
global problem;

terminalStates=getTerminalStates;
convergenceThreshold=1e-6;

Q=zeros(problem.nrStates,problem.nrActions);
