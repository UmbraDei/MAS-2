function [ outputSTN, outputValueList, absoluteIndex, valid  ] = checkTimings( inputSTN, inputValueList, selectedIndices)
    % Check for a given stn(inputSTN) if the next value of the input of
    % values (inputValueList) is a valid entry for the matrix. The
    % selectedIndices is used for calculating the absolute index.
    
    % Select min value
    [value, index] = min(inputValueList(1,2:end));
    index = index +1;
    valid = 1;
    %Output data
    absoluteIndex = calculateAbsoluteIndex(index, selectedIndices);
    outputValueList = [ inputValueList(1,1:(index-1)), inputValueList(1,(index+1):end)];
    
    %Check is value is valid
    maxValue = inputSTN(1, index);
    minValue = -inputSTN(index, 1);
    
    if value < minValue || value > maxValue
        % The value is invalid
        valid = 0;
        outputSTN = [];
        return;
    end
    % The value is valid and inserted in the stn as a fixed value.
    outputSTN = insertValue(inputSTN, index, value);

    
end

