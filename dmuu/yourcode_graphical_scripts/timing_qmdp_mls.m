nbRuns = 10;

T = zeros(1,nbOfRuns+1);
T2 = zeros(1,nbOfRuns+1);
T3 = zeros(1,nbOfRuns+1);
%% Do the different timing runs.
for i = 1:nbOfRuns+1
   tic;
   Q=vi2; 
   T(i)=  toc; 
   tic;
   
   