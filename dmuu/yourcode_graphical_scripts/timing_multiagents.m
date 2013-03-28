%% Amount of runs to do for timing analysis.
nbOfRuns = 5;

T = zeros(1,nbOfRuns+1);
T2 = zeros(1,nbOfRuns+1);
T3 = zeros(1,nbOfRuns+1);
%% Do the different timing runs.
for i = 1:nbOfRuns+1
   tic;Q=viMultiAgent; T(i)=  toc; 
   tic;Q=viMultiAgent2; T2(i) = toc; 
   tic;Q=viMultiAgentSingle; T3(i) = toc; 
   i
end

%% Filter out the first (outlying) values.
T = T(2:nbOfRuns+1);
T2 = T2(2:nbOfRuns+1);
T3 = T3(2:nbOfRuns+1);

%% Plot a comparison of the different runs. Prints the to the relevent folder.
random = num2str(randi([1,100000]));

figure(1);
hold off;
plot(T,'b');
hold on;
plot(T2,'r');

figure(2);
hold off;
semilogy(T3,'g');
hold on;
semilogy(T2,'r');

figure(3);
hold off;
plot(T3,'g');
hold on;
plot(T2,'r');

% Get the current folder
path = pwd;
[~, folderName, ~] = fileparts(path);

% Make up the graph
figure(1);
legend('Algorithm viMultiAgent', 'Algorithm viMultiAgent2');
xlabel('Run');
ylabel('Time(s)');
title(horzcat('Runtime for value iteration on multiagent problem ', folderName));

figure(2);
legend('Algorithm viMultiAgent2', 'Algorithm viMultiAgentSingle');
xlabel('Run');
ylabel('Time(s)');
limits = ylim;
limits(1) = 10^(floor(log10(limits(1))));
limits(2) = 10^(ceil(log10(limits(2))));
ylim(limits);

title(horzcat('Runtime for value iteration on multiagent problem ', folderName));


figure(3);
legend('Algorithm viMultiAgent2', 'Algorithm viMultiAgentSingle');
xlabel('Run');
ylabel('Time(s)');
ylim(limits);

title(horzcat('Runtime for value iteration on multiagent problem ', folderName));

% Export images to the correct folder.
figure(1);
filename = strcat('../../../Verslag/Timings/',folderName,'/timings_vi',random ,'.eps');
print('-depsc2',filename);
filename = strcat('../../../Verslag/Timings/',folderName,'/timings_vi',random ,'.png');
print('-dpng',filename);
hold off;

figure(2);
filename = strcat('../../../Verslag/Timings/',folderName,'/timings_vi-2',random ,'.eps');
print('-depsc2',filename);
filename = strcat('../../../Verslag/Timings/',folderName,'/timings_vi-2',random ,'.png');
print('-dpng',filename);
hold off;

figure(3);
filename = strcat('../../../Verslag/Timings/',folderName,'/timings_vi-3',random ,'.eps');
print('-depsc2',filename);
filename = strcat('../../../Verslag/Timings/',folderName,'/timings_vi-3',random ,'.png');
print('-dpng',filename);
hold off;

%% Calculate some characteristics
mean_T = mean(T)
standardDeviation_T = std(T)
mean_T2 = mean(T2)
standardDeviation_T2 = std(T2)
mean_T3 = mean(T3)
standardDeviation_T3 = std(T3)

outputMatrix = [mean_T, standardDeviation_T; mean_T2, standardDeviation_T2; mean_T3, standardDeviation_T3];
filename = strcat('../../../Verslag/Timings/',folderName,'/statistics',random ,'.txt');
save(filename, 'outputMatrix', '-ascii');

outputMatrix = [T;T2;T3];
filename = strcat('../../../Verslag/Timings/',folderName,'/data-timing',random ,'.txt');
save(filename, 'outputMatrix', '-ascii');