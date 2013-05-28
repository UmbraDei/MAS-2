function absoluteIndex = calculateAbsoluteIndex(chosenIndex, selectedIndices)
% Calculate the absolute index of an index on a given index (chosen
% index) and a given list of already chosen indexes.
    absoluteIndex = chosenIndex;
    [~, n] = size(selectedIndices);
    
    for i=1:n
        if selectedIndices(1,i) <= absoluteIndex
            absoluteIndex = absoluteIndex+1;
        end
    end