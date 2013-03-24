function sampleTrajectoriesWithBeliefs(Q)
% sample a number of trajectories through the MDP, following the
% policy specified by Q.
    global problem;
    nbOfIterations = 50;

    %% Toekennen van startpositie
    belief = problem.belief;
%    [~, state] = max(belief);
     state = find(cumsum(problem.start)>rand, 1 );

    %% 
    states = [state];
    actions = [];

    %%
    for i = 1:nbOfIterations
        %% Volgende actie
        if 0
            %% Q_MDP
            [~, action] = max(belief*Q);
        else
            %% MLS
            [~, beliefState]  = max(belief);
            action = getActionForState(Q, beliefState);
        end
        %action = getActionForState(Q, state);

        %% Volgende state
        nextState = sampleSuccessorState(state, action);
        
        %% Volgende belief
        observation = randi([1, problem.nrObservations]);
        %observation = 1;
                
        beliefNext = beliefUpdate(belief, action, observation);
        while round(sum(beliefNext)) ~=1
            observation = randi([1, problem.nrObservations]);
            beliefNext = beliefUpdate(belief, action, observation); 
        end
        
        [sum(beliefNext), state, action, observation];
        %%Updaten van de state
        state = nextState;
        belief = beliefNext;
        
        %%
        states = [states, state];
        actions = [actions, action];
        
        %% Het tekenen
        waitforbuttonpress;
        figure(1);
        plotState(state);
        figure(2);
        plot(belief);
        hold on;
        plot(state, 0, 'r*');
        hold off;
    end

    
    %for i = 1:length(states)
    %    %% Het tekenen
    %    waitforbuttonpress;
    %    i
    %    plotState(states(i));
    %end
%%    
function s = sampleSuccessorState(state, action)
    %%
    %Sample a successor state s2 (at t+1) given state s and action a at t
    
    global problem;
    
    if problem.useSparse == 0
        s = min(find(cumsum(problem.transition(:,state, action))>rand));
    else
        s = min(find(cumsum(problem.transitionS{action}(:,state))>rand));
    end





