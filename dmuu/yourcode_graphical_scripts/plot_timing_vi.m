% Get the current folder
path = pwd;
[~, folderName, ~] = fileparts(path);


filename = strcat('../../../Verslag/Timings/',folderName,'/data-timing.txt');
load(outputMatrix, 'outputMatrix', '-ascii');
T = outputMatrix(1,:);
T2 = outputMatrix(2,:);

%% Plot a comparison of the different runs. Prints the to the relevent folder.
plot(T,'b');
hold on;
plot(T2,'r');

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