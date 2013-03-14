function plotSequence(s)
% Plots the environment in state s

global problem;
global states;

b=zeros(1,problem.nrStates);

for i = 1:length(s)
    b(s(i))=i;
end

states = s;
%b(s)=1;
b
plotSingleBelief(b./max(b));
