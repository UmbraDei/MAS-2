function a = combineMMDPagentActions(a0, a1)

global problem;
a = sub2ind([sqrt(problem.nrActions), sqrt(problem.nrActions)], a0, ...
            a1);
