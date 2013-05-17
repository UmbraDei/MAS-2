inputSize = 145;
stnMatrix = loadMatrix(inputSize);
resultMatrix = zeros(1, inputSize);
selectedIndices = [];

global isAutomatic
isAutomatic = 1;

for i=2:inputSize
   [stnMatrix, index, value] = chooseValueSTN(stnMatrix, selectedIndices);
   selectedIndices = sort([selectedIndices, index]);
   resultMatrix(1, index) = value;
end

disp(['The chosen values are: ', num2str(resultMatrix)])