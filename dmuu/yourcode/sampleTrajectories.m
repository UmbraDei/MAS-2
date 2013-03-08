function states = sampleTrajectories(Q)
% sample a number of trajectories through the MDP, following the
% policy specified by Q.
global problem;

% Select a start state
startState = min(find(cumsum(problem.start)>rand));

state = startState;
states = [state];
actions = [];
for x = 1:20
    % Select next action
    nextAction = getActionForState(Q,state);
    
    nextState = sampleSuccessorState(state, nextAction);
    states = [states, nextState];
    actions = [actions, nextAction];
    
    state = nextState;
end
plotSequence(states);
states
actions





