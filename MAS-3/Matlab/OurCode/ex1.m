% This script will create file with the realiest and latest timings of
% planning for all sizes of input.

possibleSizes = [49, 97, 105, 145];
[~,nbSizes] = size(possibleSizes);
for i = 1:nbSizes
    
    O = loadMatrix(possibleSizes(i));
    maxTiming = O(1,:);
    minTiming = -O(:,1);
    
    filename = strcat('min-max', num2str(possibleSizes(i)), '.txt');
    output = (transpose([maxTiming; transpose(minTiming)]));
    save(filename, 'output', '-ascii');
end