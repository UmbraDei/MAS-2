function Q = vi_2

clear global problem;
initProblem;
global problem;

terminalStates=getTerminalStates;
convergenceThreshold=1e-6;

Q=zeros(problem.nrStates,problem.nrActions);

delta = convergenceThreshold+1;


for action=1:problem.nrActions
    if problem.useSparse == 0
       transitionMatrix = problem.transition(:, :, action);
    else
       transitionMatrix = problem.transitionS{action};
    end
    [nextStates, states, values] = find(transitionMatrix);
    transitions{action} = [nextStates, states, values];
end
        
while delta > convergenceThreshold
    QNew=zeros(problem.nrStates,problem.nrActions);
    delta = 0;
    for action=1:problem.nrActions

        nextStates = transitions{action}(:,1);
        states = transitions{action}(:,2);
        values = transitions{action}(:,3);
        %%nieuwe code
        for i = 1: length(nextStates)
            state = states(i);
            nextState = nextStates(i);
            value = values(i);
            
            QNew(state, action) = QNew(state, action) + ...
                value* max(Q(nextState,:));
        end
        
        %QNew
        
        if problem.useSparse == 0
           QNew(:, action) = problem.gamma* QNew(:, action) + problem.reward(:, action);
        else
           QNew(:, action) = problem.gamma* QNew(:, action) + problem.rewardS{action};
        end
        
        %for i = 1: length(uniqueStates)
        %    state = uniqueStates(i);
        %    QNew(state, action) = problem.reward(state,action) + problem.gamma*QNew(state, action);
        %end
       
        delta = max(delta, max(abs(Q(:, action)-QNew(:, action))));
       
    end
    %'Nieuwe Q'
    Q = QNew;
    delta;
end



