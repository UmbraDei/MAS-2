function s1 = sampleSuccessorState(s,a)
% Sample a successor state s1 (at t+1) given state s and action a at t

global problem;
s1=min(find(cumsum(problem.transition(:,s,a))>rand));
