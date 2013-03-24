initProblem;
nbOfOrders = 4;
timings = zeros(1,nbOfOrders);

for i = 1:nbOfOrders
   tic;
   S=sampleBeliefs(10^i); 
   runvi(S);
   timings(1,i) = toc;
end

timings
save -ascii timing.txt timings