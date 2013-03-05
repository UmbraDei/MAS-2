function S = getGoalState
% $Id: getGoalState.m,v 1.4 2004/02/19 13:21:23 mtjspaan Exp $

global pomdp

% goal states are the 5 most to the bottom
%[foo,S]=sort(pomdp.MS(:,2));
%S=S(1:5)+pomdp.nrStates/2;

target=[140 120];
D=sum(abs(pomdp.MS-repmat(target,length(pomdp.MS),1)),2);
[foo,S]=sort(D);
S=S(1:10)+pomdp.nrStates/2;
