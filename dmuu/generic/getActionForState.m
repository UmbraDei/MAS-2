function a = getActionForState(Q,s)
% Returns the action that has the highest value for state s in Q-table Q

global problem;

%if size(Q)~=[problem.nrStates problem.nrActions]
%  error('Q table does not have the correct dimensions');
%end

[foo,a]=max(Q(s,:));
