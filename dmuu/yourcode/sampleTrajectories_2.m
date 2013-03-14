function states = sampleTrajectories_2(Q)
% sample a number of trajectories through the MDP, following the
% policy specified by Q.
global problem;
b = problem.belief;
% Select a start state
startState = min(find(cumsum(problem.start)>rand));

state = startState;
states = [state];
actions = [];
for x = 1:20
    % Select next action
    [foo,nextAction] = max(b*Q);
    
    nextState = sampleSuccessorState(state, nextAction);
    states = [states, nextState];
    actions = [actions, nextAction];
    
    state = nextState;
    nextb = zeros(size(b));
    for i = 1:problem.nrObservations
        nextb = nextb + beliefUpdate(b,nextAction,i);
    end
    b = nextb
end
figure(1);
plotSequence(states);

figure(2);
plot(states);
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






