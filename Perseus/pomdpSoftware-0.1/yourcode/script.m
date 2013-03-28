initProblem;
nbOfOrders = 4;
nbOfRuns = 5;
timings = zeros(nbOfOrders, nbOfRuns);
meanT = zeros(nbOfOrders, nbOfRuns);
deviationT = zeros(nbOfOrders, nbOfRuns);
rewards = zeros(nbOfOrders, 1);
random = num2str(randi([1,10000]));
for i = 1:nbOfOrders
   for j = 1:nbOfRuns
       tic;
       S=sampleBeliefs(10^i); 
       runvi(S);
       timings(i,j) = toc
   end
   meanT(i,1) = mean(timings(i,:));
   deviationT(i,1) = std(timings(i,:));
   
   global backupStats
   
   R=sampleRewards(backupStats.V{length(backupStats.V)}, 100, 100, 1);
   rewards(i, 1) = mean(R(:,4));
   


end

timings
path = pwd;
[~, folderName, ~] = fileparts(path);

filename = strcat('../../../../Verslag/Timings/',folderName,'/timings-perseus-', random, '.txt');
save(filename, 'rewards', '-ascii');

filename = strcat('../../../../Verslag/Timings/',folderName,'/timings-perseus-mean', random, '.txt');
save(filename, 'meanT', '-ascii');

filename = strcat('../../../../Verslag/Timings/',folderName,'/timings-perseus-deviation', random, '.txt');
save(filename, 'deviationT', '-ascii');

filename = strcat('../../../../Verslag/Timings/',folderName,'/rewards-perseus-', random, '.txt');
save(filename, 'timings', '-ascii');