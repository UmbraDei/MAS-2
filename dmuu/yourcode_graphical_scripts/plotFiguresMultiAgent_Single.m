global problem;
%Q = viMultiAgent2;
QSingle = viMultiAgentSingle;
% Get the current folder
path = pwd;
[~, folderName, ~] = fileparts(path);
    
for i = 1:1
    randomNumber = num2str(randi([1,10^10]));

    [statesSingle, ~] = sampleTrajectoriesMultiAgentsSingle(QSingle);
    
    for state = 1:50

        plotState(statesSingle(state));

        stateStr = num2str(state);
        filename = strcat('../../../Verslag/Paths/',folderName,'/plot-single-', randomNumber, '-part-', stateStr, '.eps');
        print('-depsc2',filename);
        filename = strcat('../../../Verslag/Paths/',folderName,'/plot-single-', randomNumber, '-part-', stateStr, '.png');
        print('-dpng',filename);
        hold off;
    end
   
    
end