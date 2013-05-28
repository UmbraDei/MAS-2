inputSize = 145;
resultMatrix = importdata('correct145.tab');

stnMatrix = loadMatrix(inputSize);
%resultMatrix = [0  0  4  2  5];
%resultMatrix = [0  1  4  2  5];
%resultMatrix = [0  0  4  2 8];
selectedIndices = [];
itResultMatrix = resultMatrix;

for i=2:inputSize
   [ stnMatrix, itResultMatrix, absoluteIndex, valid  ] = checkTimings( stnMatrix, itResultMatrix, selectedIndices);
   selectedIndices = sort([selectedIndices, absoluteIndex]);
   if valid == 0
       break;
   end
end

if valid == 0
    disp(['The matrix was invalid starting from index: ', num2str(absoluteIndex), ...
                ' (value ', num2str(resultMatrix(1,absoluteIndex)), ')'])
else
    disp(['The matrix was valid'])
end