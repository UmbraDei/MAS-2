function transitionMatrix = getTransitionMatrix(a)
global problem;

if problem.useSparse == 0
       transitionMatrix = problem.transition(:, :, a);
else
       transitionMatrix = problem.transitionS{a};
end