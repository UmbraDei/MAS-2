initProblem;
nbOfOrders = 4;
timings = zeros(1,nbOfOrders);

for i = 1:nbOfOrders
   tic;
   S=sampleBeliefs(10^i); 
   runvi(S);
   timings(1,i) = toc;
   
   global backupStats
   
   rewards = zeros(1,length(backupStats.V));
   for iterationValue=1:length(backupStats.V)
        R=sampleRewards(backupStats.V{iterationValue});
        rewards(iterationValue) = mean(R(:,4));
   end
   
   filename = strcat('../../../Verslag/Timings/',folderName,'/rewards-perseus-', i, '.txt');
   save(filename, 'rewards', '-ascii');
end

timings
[~, folderName, ~] = fileparts(path);

filename = strcat('../../../Verslag/Timings/',folderName,'/timings-perseus-', i, '.txt');
save(filename, timings, '-ascii');