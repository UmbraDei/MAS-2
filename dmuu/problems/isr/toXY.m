function [x,y] = toXY(s)

global problem;

[x,y]=find(problem.map==s);
