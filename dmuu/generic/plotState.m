function plotState(s)
% Plots the environment in state s

global problem;

b=zeros(1,problem.nrStates);
b(s)=1;

plotSingleBelief(b);
