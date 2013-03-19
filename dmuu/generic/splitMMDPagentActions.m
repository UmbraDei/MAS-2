function [a0, a1] = splitMMDPagentActions(a)

global problem;
[a0, a1] = ind2sub([sqrt(problem.nrActions), sqrt(problem.nrActions)], a);
