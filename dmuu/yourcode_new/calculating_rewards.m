Q = vi_2;


global problem;
nbIteration = 100;
rewardBasic = zeros(1,nbIteration);
rewardBeliefsQMDP = zeros(1,nbIteration);
rewardBeliefsMLS = zeros(1,nbIteration);
for iteration = 1:nbIteration
    [statesBasic, actionsBasic] = sampleTrajectories(Q);
    [statesBeliefsQMDP, actionsBeliefsQMDP] = sampleTrajectoriesWithBeliefsQMDP(Q);
    [statesBeliefsMLS, actionsBeliefsMLS] = sampleTrajectoriesWithBeliefsMLS(Q);
    for state=1:length(actionsBasic)
        indRewards = problem.reward(statesBasic(state), actionsBasic(state));
        rewardBasic(1,iteration) = rewardBasic(1,iteration) +  indRewards * problem.gamma^(state-1);
        
        indRewards = problem.reward(statesBeliefsQMDP(state), actionsBeliefsQMDP(state));
        rewardBeliefsQMDP(1,iteration) = rewardBeliefsQMDP(1,iteration) +  indRewards * problem.gamma^(state-1);
        
        indRewards = problem.reward(statesBeliefsMLS(state), actionsBeliefsMLS(state));
        rewardBeliefsMLS(1,iteration) = rewardBeliefsMLS(1,iteration) +  indRewards * problem.gamma^(state-1);
    end
    
    iteration
end 

path = pwd;
[~, folderName, ~] = fileparts(path);

mean_T = mean(rewardBasic)
standardDeviation_T = std(rewardBasic)
outputMatrix = [mean_T, standardDeviation_T];
filename = strcat('../../../Verslag/Timings/',folderName,'/rewards-timing-basic-nbOfIterations-', num2str(nbIteration), '.txt');
save(filename, 'outputMatrix', '-ascii');

mean_T = mean(rewardBeliefsQMDP)
standardDeviation_T = std(rewardBeliefsQMDP)
outputMatrix = [mean_T, standardDeviation_T];
filename = strcat('../../../Verslag/Timings/',folderName,'/rewards-timing-beliefs-QMDP- nbOfIterations-', num2str(nbIteration), '.txt');
save(filename, 'outputMatrix', '-ascii');

mean_T = mean(rewardBeliefsMLS)
standardDeviation_T = std(rewardBeliefsMLS)
outputMatrix = [mean_T, standardDeviation_T];
filename = strcat('../../../Verslag/Timings/',folderName,'/rewards-timing-beliefs-MLS- nbOfIterations-', num2str(nbIteration), '.txt');
save(filename, 'outputMatrix', '-ascii');

reward = 0;
for state = 1: problem.nrStates
    reward = reward + problem.belief(1,state)*max(Q(state, :));
end
filename = strcat('../../../Verslag/Timings/',folderName,'/rewards-with-intial-Q.txt');
save(filename, 'reward', '-ascii');

