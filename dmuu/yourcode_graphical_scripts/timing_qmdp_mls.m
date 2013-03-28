nbOfRuns = 5;
nrOfSamples = 100;

T = zeros(1,nbOfRuns+1);
T2 = zeros(1,nbOfRuns+1);
T3 = zeros(1,nbOfRuns+1);
%% Do the different timing runs.
for i = 1:nbOfRuns+1
    
   %%vi
   tic;
   Q=vi_2;
   global problem;
   T(i)=  toc; 
   
   %% QMDP
   tic;
   for j = 1:nrOfSamples
       [states, actions, ~] = sampleTrajectoriesWithBeliefsQMDP(Q);
       reward = 0;
       for state=1:length(actions)
           indRewards = problem.reward(states(state), actions(state));
           reward = reward +  indRewards * problem.gamma^(state-1);
       end
   end
   T2(i) = toc;
   
   %% MLS
   tic;
   for j = 1:nrOfSamples
       [states, actions, ~] = sampleTrajectoriesWithBeliefsMLS(Q);
       reward = 0;
       for state=1:length(actions)
           indRewards = problem.reward(states(state), actions(state));
           reward = reward +  indRewards * problem.gamma^(state-1);
       end
   end
   T3(i) = toc;
end

T2 = T + T2;
T3 = T + T3;

T2 = T2(:, 2:nbOfRuns+1);
T3 = T3(:, 2:nbOfRuns+1);

path = pwd;
[~, folderName, ~] = fileparts(path);
random = num2str(randi([1,100000]));

mean_T = mean(T2)
standardDeviation_T = std(T2)
outputMatrix = [mean_T, standardDeviation_T];
filename = strcat('../../../Verslag/WholeIterationTiming/',folderName,'/computing-whole-iteration-qmdp-', random, '.txt');
save(filename, 'outputMatrix', '-ascii');

mean_T = mean(T3)
standardDeviation_T = std(T3)
outputMatrix = [mean_T, standardDeviation_T];
filename = strcat('../../../Verslag/WholeIterationTiming/',folderName,'/computing-whole-iteration-mls-', random, '.txt');
save(filename, 'outputMatrix', '-ascii');
   