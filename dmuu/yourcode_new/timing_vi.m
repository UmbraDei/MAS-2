%% Amount of runs to do for timing analysis.
nbOfRuns = 20;

T = zeros(1,nbOfRuns+1);
T2 = zeros(1,nbOfRuns+1);

%% Do the different timing runs.
for i = 1:nbOfRuns+1
   tic;
   Q=vi;
   T(i)= toc; 
   
   tic;
   Q=vi_2; 
   T2(i) = toc; 
end

%% Filter out the first (outlying) values.
T = T(2:nbOfRuns+1);
T2 = T2(2:nbOfRuns+1);

%% Plot a comparison of the different runs. Prints the to the relevent folder.
plot(T,'b');
hold on;
plot(T2,'r');

% Get the current folder
path = pwd;
[~, folderName, ~] = fileparts(path);

% Make up the graph
legend('Algorithm vi', 'Algorithm vi_2');
xlabel('Run');
ylabel('Time(s)');
title(horzcat('Runtime for value iteration on problem ', folderName));

% Export images to the correct folder.
filename = strcat('../../../Verslag/Timings/',folderName,'/timings_vi.eps');
print('-depsc2',filename);
filename = strcat('../../../Verslag/Timings/',folderName,'/timings_vi.png');
print('-dpng',filename);

hold off;

%% Calculate some characteristics
mean_T = mean(T)
standardDeviation_T = std(T)
mean_T2 = mean(T2)
standardDeviation_T2 = std(T2)

outputMatrix = [mean_T, standardDeviation_T; mean_T2, standardDeviation_T2];
filename = strcat('../../../Verslag/Timings/',folderName,'/statistics.txt');
save(filename, 'outputMatrix', '-ascii');