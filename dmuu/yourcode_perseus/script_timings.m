initProblem;
nbOfOrders = 4;
nbOfRuns = 5;
timings = zeros(nbOfOrders, nbOfRuns);
meanT = zeros(nbOfOrders, 1);
deviationT = zeros(nbOfOrders, 1);
random = num2str(randi([1,10000]));
rewards = zeros(nbOfOrders, nbOfRuns);
meanR = zeros(nbOfOrders, 1);
deviationR = zeros(nbOfOrders, 1);
for i = 1:nbOfOrders
    
   for j = 1:nbOfRuns
       tic;
       S=sampleBeliefs(10^i); 
       runvi(S);
       global backupStats;
       R=sampleRewards(backupStats.V{length(backupStats.V)}, 100, 100, 1);
       rewards(i, j) = mean(R(:,4));
       rewards(i, j) = std(R(:,4));
       timings(i,j) = toc;
   end
   meanT(i,1) = mean(timings(i,:));
   deviationT(i,1) = std(timings(i,:));
   meanR(i,1) = mean(rewards(i,:));
   deviationR(i,1) = std(rewards(i,:));
   


end

timings
path = pwd;
[~, folderName, ~] = fileparts(path);

filename = strcat('../../../../Verslag/Perseus/',folderName,'/timings-perseus-all-', random, '.txt');
save(filename, 'timings', '-ascii');

filename = strcat('../../../../Verslag/Perseus/',folderName,'/timings-perseus-all-mean-', random, '.txt');
save(filename, 'meanT', '-ascii');

filename = strcat('../../../../Verslag/Perseus/',folderName,'/timings-perseus-all-deviation-', random, '.txt');
save(filename, 'deviationT', '-ascii');

filename = strcat('../../../../Verslag/Perseus/',folderName,'/timings-perseus-all-rewards-', random, '.txt');
save(filename, 'rewards', '-ascii');

filename = strcat('../../../../Verslag/Perseus/',folderName,'/timings-perseus-all-rewards-mean', random, '.txt');
save(filename, 'meanR', '-ascii');

filename = strcat('../../../../Verslag/Perseus/',folderName,'/timings-perseus-all-rewards-deviation-', random, '.txt');
save(filename, 'deviationR', '-ascii');

