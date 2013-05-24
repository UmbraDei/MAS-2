output = loadFile();
[status4, outputSTN4] = calculateNbOfRunwaysWithThreshold(output,4);
[status3, outputSTN3] = calculateNbOfRunwaysWithThreshold(output,3);
[status2, outputSTN2] = calculateNbOfRunwaysWithThreshold(output,2);
%[output1, output2, output3] = calculateNbOfRunways(output);


