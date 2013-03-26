function Q = viMultiAgentSingle

clear global problem;
initProblem;
global problem;

%terminalStates=getTerminalStates;
convergenceThreshold=1e-6;

[nrStates, ~, nrActions] = size(problem.transitionInd{1});

for agent = 1:length(problem.transitionInd)
    QAgent=zeros(nrStates,nrActions);

    delta = convergenceThreshold+1;
    for action=1:nrActions
        transitionMatrix{action} = sparse(problem.transitionInd{agent}(:,:,action));
    end

    while delta > convergenceThreshold
        
        QNew=zeros(nrStates,nrActions);
        delta = 0;
        for action=1:nrActions

            [nextStates, states, values] = find(transitionMatrix{action});

            %%nieuwe code
            for i = 1: length(nextStates)
                state = states(i);
                nextState = nextStates(i);
                value = values(i);

                QNew(state, action) = QNew(state, action) + ...
                    value* max(QAgent(nextState,:));
            end

            %QNew

            QNew(:, action) = problem.gamma* QNew(:, action) + problem.rewardInd{agent}(:, action);


            %for i = 1: length(uniqueStates)
            %    state = uniqueStates(i);
            %    QNew(state, action) = problem.reward(state,action) + problem.gamma*QNew(state, action);
            %end

            delta = max(delta, max(abs(QAgent(:, action)-QNew(:, action))));

           %action
        end
        %'Nieuwe Q'
        QAgent = QNew;
        delta
    end
    
    Q{agent} = QAgent;
end



