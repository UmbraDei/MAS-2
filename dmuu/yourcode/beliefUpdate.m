function b1 = beliefUpdate(b,a,o)
% Update belief b to b1 taking action a (from b) and receiving observation o

global problem;

b1=zeros(1,problem.nrStates);
