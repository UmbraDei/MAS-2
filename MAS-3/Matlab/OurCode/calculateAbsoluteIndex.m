function absoluteIndex = calculateAbsoluteIndex(chosenIndex, selectedIndices)

    absoluteIndex = chosenIndex;
    [~, n] = size(selectedIndices);
    
    for i=1:n
        if selectedIndices(1,i) <= absoluteIndex
            absoluteIndex = absoluteIndex+1;
        end
    end