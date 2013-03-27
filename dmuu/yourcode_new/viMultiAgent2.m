function Q = viMultiAgent2

clear global problem;
initProblem;
global problem;

%terminalStates=getTerminalStates;
convergenceThreshold=1e-6;

Q=zeros(problem.nrStates,problem.nrActions);

delta = convergenceThreshold+1;

for action=1:problem.nrActions
    transitionMatrix{action} = sparse(problem.transition(:,:,action));
end
     
while delta > convergenceThreshold
    QNew=zeros(problem.nrStates,problem.nrActions);
    delta = 0;
    for action=1:problem.nrActions
       
        [nextStates, states, values] = find(transitionMatrix{action});
        
        %%nieuwe code
        for i = 1: length(nextStates)
            state = states(i);
            nextState = nextStates(i);
            value = values(i);
            
            QNew(state, action) = QNew(state, action) + ...
                value* max(Q(nextState,:));
        end
        
        %QNew
        
        QNew(:, action) = problem.gamma* QNew(:, action) + problem.reward(:, action);
        
        
        %for i = 1: length(uniqueStates)
        %    state = uniqueStates(i);
        %    QNew(state, action) = problem.reward(state,action) + problem.gamma*QNew(state, action);
        %end
       
        delta = max(delta, max(abs(Q(:, action)-QNew(:, action))));

       %action
    end
    %'Nieuwe Q'
    Q = QNew;
    delta;
end



