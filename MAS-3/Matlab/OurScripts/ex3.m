% This script let you choose values for a given stn problem. By placing the
% isAutomatic on 1, the script will choose random values.
inputSize = 49;
stnMatrix = loadMatrix(inputSize);
resultMatrix = zeros(1, inputSize);
selectedIndices = [];

global isAutomatic
isAutomatic = 0;

for i=2:inputSize
   [stnMatrix, index, value] = chooseValueSTN(stnMatrix, selectedIndices);
   selectedIndices = sort([selectedIndices, index]);
   resultMatrix(1, index) = value;
end

disp(['The chosen values are: ', num2str(resultMatrix)])