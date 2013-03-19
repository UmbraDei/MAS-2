function [s0, s1] = splitMMDPagentStates(s)

global problem;
[s0, s1] = ind2sub([sqrt(problem.nrStates), sqrt(problem.nrStates)], s);
