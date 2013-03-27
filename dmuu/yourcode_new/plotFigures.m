global problem;
Q = vi_2;
% Get the current folder
path = pwd;
[~, folderName, ~] = fileparts(path);
    
for i = 1:2
    randomNumber = num2str(randi([1,10^10]));
    %%
    [states, ~] = sampleTrajectories(Q);

    states = states(1:20);
    figure(1);
    plotSequence(states);
    
    figure(2);
    plot(states);
    
    figure(1)
    filename = strcat('../../../Verslag/Paths/',folderName,'/plot-basic-part1-', randomNumber, '.eps');
    print('-depsc2',filename);
    filename = strcat('../../../Verslag/Paths/',folderName,'/plot-basic-part1-', randomNumber, '.png');
    print('-dpng',filename);
    hold off;

    figure(2)
    filename = strcat('../../../Verslag/Paths/',folderName,'/plot-basic-part2-', randomNumber, '.eps');
    print('-depsc2',filename);
    filename = strcat('../../../Verslag/Paths/',folderName,'/plot-basic-part2-', randomNumber, '.png');
    print('-dpng',filename);
    hold off;

    %%
    [states, ~, beliefs] = sampleTrajectoriesWithBeliefsQMDP(Q);

    states = states(1:20);
    figure(1);
    plotSequence(states);

    figure(2);
    plot(states);
    
    figure(3);
    plot(full(beliefs(1,:)));
    ylim([0,max(beliefs(1,:))*1.1]);
    
    figure(4);
    plot(full(beliefs(20,:)));
    
    figure(1);
    filename = strcat('../../../Verslag/Paths/',folderName,'/plot-QMDP-part1-', randomNumber, '.eps');
    print('-depsc2',filename);
    filename = strcat('../../../Verslag/Paths/',folderName,'/plot-QMDP-part1-', randomNumber, '.png');
    print('-dpng',filename);
    hold off;
    
    figure(2)
    filename = strcat('../../../Verslag/Paths/',folderName,'/plot-QMDP-part2-', randomNumber, '.eps');
    print('-depsc2',filename);
    filename = strcat('../../../Verslag/Paths/',folderName,'/plot-QMDP-part2-', randomNumber, '.png');
    print('-dpng',filename);
    hold off;
    
    figure(3)
    filename = strcat('../../../Verslag/Paths/',folderName,'/plot-QMDP-bel-1-', randomNumber, '.eps');
    print('-depsc2',filename);
    filename = strcat('../../../Verslag/Paths/',folderName,'/plot-QMDP-bel-1-', randomNumber, '.png');
    print('-dpng',filename);
    hold off;
    
    figure(4)
    filename = strcat('../../../Verslag/Paths/',folderName,'/plot-QMDP-bel-2-', randomNumber, '.eps');
    print('-depsc2',filename);
    filename = strcat('../../../Verslag/Paths/',folderName,'/plot-QMDP-bel-2-', randomNumber, '.png');
    print('-dpng',filename);
    hold off;
    

    %%
    [states, ~, beliefs] = sampleTrajectoriesWithBeliefsMLS(Q);

    states = states(1:20);
    figure(1);
    plotSequence(states);

    figure(2);
    plot(states);
    
    figure(3);
    plot(full(beliefs(1,:)));
    ylim([0,max(beliefs(1,:))*1.1]);
    
    figure(4);
    plot(full(beliefs(20,:)));
    
    figure(1);
    filename = strcat('../../../Verslag/Paths/',folderName,'/plot-MLS-part1-', randomNumber, '.eps');
    print('-depsc2',filename);
    filename = strcat('../../../Verslag/Paths/',folderName,'/plot-MLS-part1-', randomNumber, '.png');
    print('-dpng',filename);
    hold off;
    
    figure(2)
    filename = strcat('../../../Verslag/Paths/',folderName,'/plot-MLS-part2-', randomNumber, '.eps');
    print('-depsc2',filename);
    filename = strcat('../../../Verslag/Paths/',folderName,'/plot-MLS-part2-', randomNumber, '.png');
    print('-dpng',filename);
    hold off;
    
    figure(3)
    filename = strcat('../../../Verslag/Paths/',folderName,'/plot-MLS-bel-1-', randomNumber, '.eps');
    print('-depsc2',filename);
    filename = strcat('../../../Verslag/Paths/',folderName,'/plot-MLS-bel-1-', randomNumber, '.png');
    print('-dpng',filename);
    hold off;
    
    figure(4)
    filename = strcat('../../../Verslag/Paths/',folderName,'/plot-MLS-bel-2-', randomNumber, '.eps');
    print('-depsc2',filename);
    filename = strcat('../../../Verslag/Paths/',folderName,'/plot-MLS-bel-2-', randomNumber, '.png');
    print('-dpng',filename);
    hold off;
end