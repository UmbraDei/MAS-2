function s = combineMMDPagentStates(s0, s1)

global problem;
s = sub2ind([sqrt(problem.nrStates), sqrt(problem.nrStates)], s0, ...
            s1);



