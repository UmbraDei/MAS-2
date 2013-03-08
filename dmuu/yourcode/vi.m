function Q = vi

clear global problem;
initProblem;
global problem;

terminalStates=getTerminalStates;
convergenceThreshold=1e-6;

Q=zeros(problem.nrStates,problem.nrActions);
eps = 0.0001;

delta = eps +1;

while delta > eps
    QNew=zeros(problem.nrStates,problem.nrActions);
    delta = 0;
    for state=1:problem.nrStates
       for action=1:problem.nrActions
           
           v = Q(state, action);
           
           tempSum = 0;
           for nextState = 1: problem.nrStates
               tempSum = tempSum  + ...
                    problem.transition(nextState, state, action)* max(Q(nextState,:));
           end
           
           QNew(state, action) = problem.reward(state,action) + problem.gamma*tempSum;
           
           delta = max(delta, abs(v-QNew(state, action)));
       end
    end
    Q = QNew;
end



