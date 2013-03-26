function Q = vi

clear global problem;
initProblem;
global problem;

terminalStates=getTerminalStates;
convergenceThreshold=1e-6;

Q=zeros(problem.nrStates,problem.nrActions);

delta = convergenceThreshold+1;

while delta > convergenceThreshold
    QNew=zeros(problem.nrStates,problem.nrActions);
    delta = 0;
    for action=1:problem.nrActions
        if problem.useSparse == 0
           transitionMatrix = problem.transition(:, :, action);
        else
           transitionMatrix = problem.transitionS{action};
        end
        [nextStates, states, values] = find(transitionMatrix);
        
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
        %% uitgecomment
        if 0
            for state=1:problem.nrStates


               v = Q(state, action);

               tempSum = 0;
               for nextState = 1: problem.nrStates
                   if problem.useSparse == 0
                       tempSum = tempSum  + ...
                            problem.transition(nextState, state, action)* max(Q(nextState,:));
                   else
                       tempSum = tempSum  + ...
                            problem.transitionS{action}(nextState, state)* max(Q(nextState,:));
                   end
               end

               QNew(state, action) = problem.reward(state,action) + problem.gamma*tempSum;

               delta = max(delta, abs(v-QNew(state, action)));
            end
        end
       %action
    end
    %'Nieuwe Q'
    Q = QNew;
    delta;
end



