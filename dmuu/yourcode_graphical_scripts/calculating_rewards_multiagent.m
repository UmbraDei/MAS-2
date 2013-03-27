Q = viMultiAgent2;
QSingle = viMultiAgentSingle;

global problem;
nbIteration = 100;
rewardBasic = zeros(1,nbIteration);
rewardBeliefs = zeros(1,nbIteration);
for iteration = 1:nbIteration
    [statesBasic, actionsBasic] = sampleTrajectoriesMultiAgents(Q);
    [statesBeliefs, actionsBeliefs] = sampleTrajectoriesMultiAgentsSingle(QSingle);
    for state=1:length(actionsBasic)
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
filename = strcat('../../../Verslag/Timings/',folderName,'/rewards-timing-toghether-nbOfIterations-', num2str(nbIteration), '.txt');
save(filename, 'outputMatrix', '-ascii');

mean_T = mean(rewardBeliefs)
standardDeviation_T = std(rewardBeliefs)

outputMatrix = [mean_T, standardDeviation_T];
filename = strcat('../../../Verslag/Timings/',folderName,'/rewards-timing-single-nbOfIterations-', num2str(nbIteration), '.txt');
save(filename, 'outputMatrix', '-ascii');


