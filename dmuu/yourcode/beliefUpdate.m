function b1 = beliefUpdate(b,a,o)
% Update belief b to b1 taking action a (from b) and receiving observation o
% With b the vector of the beliefs

global problem;

%b1=zeros(1,problem.nrStates);

transitionMatrix = getTransitionMatrix(a);
observationMatrix = getObservationMatrix(a);

b1 = (observationMatrix(:,o) .* (transitionMatrix*b.')).';

end



