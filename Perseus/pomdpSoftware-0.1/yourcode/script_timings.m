initProblem;
nbOfOrders = 4;
nbOfRuns = 1;
timings = zeros(nbOfOrders, nbOfRuns);
meanT = zeros(nbOfOrders, nbOfRuns);
deviationT = zeros(nbOfOrders, nbOfRuns);
random = num2str(randi([1,10000]));

for i = 1:nbOfOrders
    
   for j = 1:nbOfRuns
       tic;
       S=sampleBeliefs(10^i); 
       runvi(S);
       global backupStats;
       R=sampleRewards(backupStats.V{length(backupStats.V)}, 100, 100, 1);
       timings(i,j) = toc;
   end
   meanT(i,1) = mean(timings(i,:));
   deviationT(i,1) = std(timings(i,:));
   
   


end

timings
path = pwd;
[~, folderName, ~] = fileparts(path);

filename = strcat('../../../../Verslag/Timings/',folderName,'/timings-perseus-all-', random, '.txt');
save(filename, 'timings', '-ascii');

filename = strcat('../../../../Verslag/Timings/',folderName,'/timings-perseus-all-mean-', random, '.txt');
save(filename, 'meanT', '-ascii');

filename = strcat('../../../../Verslag/Timings/',folderName,'/timings-perseus-all-deviation-', random, '.txt');
save(filename, 'deviationT', '-ascii');
