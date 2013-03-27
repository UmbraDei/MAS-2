Q = vi_2;


global problem;
nbIteration = 100;
rewardBasic = zeros(1,nbIteration);
rewardBeliefs = zeros(1,nbIteration);
for iteration = 1:nbIteration
    [statesBasic, actionsBasic] = sampleTrajectories(Q);
    [statesBeliefs, actionsBeliefs] = sampleTrajectoriesWithBeliefs(Q);
    for state=1:length(actions)
        indRewards = problem.reward(statesBasic(state), actionsBasic(state));
        rewardBasic(1,iteration) = rewardBasic(1,iteration) +  indRewards * problem.gamma^(state-1);
        
        indRewards = problem.reward(statesBeliefs(state), actionsBeliefs(state));
        rewardBeliefs(1,iteration) = rewardBeliefs(1,iteration) +  indRewards * problem.gamma^(state-1);
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

mean_T = mean(rewardBeliefs)
standardDeviation_T = std(rewardBeliefs)

outputMatrix = [mean_T, standardDeviation_T];
filename = strcat('../../../Verslag/Timings/',folderName,'/rewards-timing-beliefs-nbOfIterations-', num2str(nbIteration), '.txt');
save(filename, 'outputMatrix', '-ascii');


