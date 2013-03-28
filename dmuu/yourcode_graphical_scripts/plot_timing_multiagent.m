% Get the current folder
path = pwd;
[~, folderName, ~] = fileparts(path);


filename = strcat('../../../Verslag/Timings/',folderName,'/data-timing.txt');
outputMatrix = load(filename, '-ascii');
T = outputMatrix(1,:);
T2 = outputMatrix(2,:);
T3 = outputMatrix(3,:);

%% Plot a comparison of the different runs. Prints the to the relevent folder.

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

% Make up the graph
figure(1);
legend('Algorithm viMultiAgent', 'Algorithm viMultiAgent2', 'Location', 'East');
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
filename = strcat('../../../Verslag/Timings/',folderName,'/timings_vi.eps');
print('-depsc2',filename);
filename = strcat('../../../Verslag/Timings/',folderName,'/timings_vi.png');
print('-dpng',filename);
hold off;

figure(2);
filename = strcat('../../../Verslag/Timings/',folderName,'/timings_vi-2.eps');
print('-depsc2',filename);
filename = strcat('../../../Verslag/Timings/',folderName,'/timings_vi-2.png');
print('-dpng',filename);
hold off;

figure(3);
filename = strcat('../../../Verslag/Timings/',folderName,'/timings_vi-3.eps');
print('-depsc2',filename);
filename = strcat('../../../Verslag/Timings/',folderName,'/timings_vi-3.png');
print('-dpng',filename);
hold off;