function [states,actions] = sampleTrajectories(Q)
% sample a number of trajectories through the MDP, following the
% policy specified by Q.
    global problem;
    nbOfIterations = 100;

    %% Toekennen van startpositie
    state = find(cumsum(problem.start)>rand, 1 );

    %% Het tekenen
    plotState(state);
    %waitforbuttonpress;

    %% 
    states = [state];
    actions = [];

    %%
    for i = 1:nbOfIterations
        %% Volgende actie
        action = getActionForState(Q, state);

        %% Volgende state
        nextState = sampleSuccessorState(state, action);

        %% Het tekenen
        %waitforbuttonpress;
        %plotState(nextState);

        %%Updaten van de state
        state = nextState;

        %%
        states = [states, state];
        actions = [actions, action];
    end

function s = sampleSuccessorState(state, action)
    %Sample a successor state s2 (at t+1) given state s and action a at t
    
    global problem;
    
    if problem.useSparse == 0
        s = min(find(cumsum(problem.transition(:,state, action))>rand));
    else
        s = min(find(cumsum(problem.transitionS{action}(:,state))>rand));
    end





