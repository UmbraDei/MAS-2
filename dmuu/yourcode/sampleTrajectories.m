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

function s1 = sampleSuccessorState(s,a)
% Sample a successor state s1 (at t+1) given state s and action a at t

global problem;

if problem.useSparse == 0
   s1=min(find(cumsum(problem.transition(:,s,a))>rand));
else
   s1=min(find(cumsum(problem.transitionS{a}(:,s))>rand));
end






