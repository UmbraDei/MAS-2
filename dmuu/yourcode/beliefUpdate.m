function b1 = beliefUpdate(b,a)
% Update belief b to b1 taking action a (from b) and receiving observation o
% With b the vector of the beliefs

global problem;

%b1=zeros(1,problem.nrStates);

transitionMatrix = getTransitionMatrix(a);
observationMatrix = getObservationMatrix(a);
o = randi([1,problem.nrObservations]);
%o = randi([1,2]);
%o = 1;

b1 = (observationMatrix(:,o) .* (transitionMatrix*b.')).';

%while sum(abs(b1)) == 0
%    'Lusje!!!';
%    o = randi([1,problem.nrObservations-1])
%
%    b1 = (observationMatrix(:,o) .* (transitionMatrix*b.')).';
%end




