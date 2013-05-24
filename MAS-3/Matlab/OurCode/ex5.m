output = loadFile();
[status207, outputSTN207] = calculateNbOfRunwaysWithThreshold(output,207);
save('output/207planes-b.mat', 'outputSTN207');
[status4, outputSTN4] = calculateNbOfRunwaysWithThreshold(output,4);
save('output/4planes-b.mat', 'outputSTN4');
[status3, outputSTN3] = calculateNbOfRunwaysWithThreshold(output,3);
save('output/3planes-b.mat', 'outputSTN3');
[status2, outputSTN2] = calculateNbOfRunwaysWithThreshold(output,2);
save('output/2planes-b.mat', 'outputSTN2');
%[output1, output2, output3] = calculateNbOfRunways(output);


