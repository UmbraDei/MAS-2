function [outputSTN, absoluteIndex, inputValue] = chooseValueSTN( inputSTN, selectedIndices )
%CHOOSEVALUESTN Summary of this function goes here
%   Detailed explanation goes here
    global isAutomatic
    
    [~, sizeInput] = size(inputSTN);
    
    if sizeInput == 1
        error('Matrix is 1x1');
    end
    
    chosenIndex = randi([2, sizeInput]);
    
    absoluteIndex = calculateAbsoluteIndex(chosenIndex, selectedIndices);
    
    
    maxValue = inputSTN(1, chosenIndex);
    minValue = -inputSTN(chosenIndex, 1);
    prompt = ['Choose a value for variable ', num2str(absoluteIndex), ...
                        ' in the range of ', num2str(minValue), ...
                        ' and ', num2str(maxValue), '? '];
                    
    if minValue == maxValue
        inputValue = minValue;
        disp(['The variable ', num2str(absoluteIndex), ' is assigned to it''s only possible value ', num2str(inputValue), '.']);
    elseif isAutomatic == 1
        inputValue = randi([minValue, maxValue]); 
        disp([prompt, num2str(inputValue)]);
    else 
        inputValue = input(prompt);
    end
    
    while inputValue < minValue || inputValue > maxValue
        disp('You value isn''t in the given range');
        inputValue = input(prompt);
    end
    
    outputSTN = insertValue(inputSTN, chosenIndex, inputValue);

    
end
