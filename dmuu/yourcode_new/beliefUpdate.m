function b1 = beliefUpdate(b,a,o)
% Update belief b to b1 taking action a (from b) and receiving observation o


b1Temp = getTransitionMatrix(a)*b';
obs = getObservationMatrix(a,o);
b1 = obs .* b1Temp;

b1 = b1' / sum(b1);




function observationMatrix = getObservationMatrix(a, o)

    global problem;
    if problem.useSparse == 0
        observationMatrix = problem.observation(:,a, o);
    else
        observationMatrix = problem.observationS{a}(:,o);
    end
    
function s = getTransitionMatrix(action)
    global problem;
    
    if problem.useSparse == 0
        s = problem.transition(:,:, action);
    else
        s = problem.transitionS{action}(:,:);
    end

