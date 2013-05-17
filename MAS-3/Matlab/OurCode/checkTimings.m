function [ outputSTN, outputValueList, absoluteIndex, valid  ] = checkTimings( inputSTN, inputValueList, selectedIndices)

    [value, index] = min(inputValueList(1,2:end));
    index = index +1;
    valid = 1;
    absoluteIndex = calculateAbsoluteIndex(index, selectedIndices);
    outputValueList = [ inputValueList(1,1:(index-1)), inputValueList(1,(index+1):end)];
    
    maxValue = inputSTN(1, index);
    minValue = -inputSTN(index, 1);
    
    if value < minValue || value > maxValue
        valid = 0;
        outputSTN = [];
        return;
    end
    
    outputSTN = insertValue(inputSTN, index, value);

    
end

