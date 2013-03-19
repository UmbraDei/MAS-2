function observationMatrix = getObservationMatrix(a)
global problem;

if problem.useSparse == 0
       observationMatrix = problem.observation(:, a, :);
else
       observationMatrix = problem.observationS{a};
end