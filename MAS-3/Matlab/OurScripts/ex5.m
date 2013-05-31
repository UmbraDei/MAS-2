% This script will check the minimal nb of runways needed and export a stn
% for this problem.
output = loadFile();
disp('Test for 1 runway');
[status1, outputSTN1] = calculateNbOfRunwaysWithThreshold(output,1);
save('output/1planes-b.mat', 'outputSTN1');

disp(' ');
disp('Test for 2 runways');
[status2, outputSTN2] = calculateNbOfRunwaysWithThreshold(output,2);
save('output/2planes-b.mat', 'outputSTN2');

disp(' ');
disp('Test for 3 runways');
[status3, outputSTN3] = calculateNbOfRunwaysWithThreshold(output,3);
save('output/3planes-b.mat', 'outputSTN3');

disp(' ');
disp('Test for 4 runways');
[status4, outputSTN4] = calculateNbOfRunwaysWithThreshold(output,4);
save('output/4planes-b.mat', 'outputSTN4');

disp(' ');
disp('Test for 207 runways');

[status207, outputSTN207] = calculateNbOfRunwaysWithThreshold(output,207);
save('output/207planes-b.mat', 'outputSTN207');



%[output1, output2, output3] = calculateNbOfRunways(output);


