function [outputSTN, absoluteIndex, inputValue] = chooseValueSTN( inputSTN, selectedIndices )
% Choose a value for a random chosen value out of the inputmatrix with
% already selected indices.

    global isAutomatic
    
    [~, sizeInput] = size(inputSTN);
    
    if sizeInput == 1 % We are done
        error('Matrix is 1x1');
    end
    
    chosenIndex = randi([2, sizeInput]); % Random value from 2 till the end (all the freedom parameters)
    
    absoluteIndex = calculateAbsoluteIndex(chosenIndex, selectedIndices); 
    
    % Calculate interval 
    maxValue = inputSTN(1, chosenIndex);
    minValue = -inputSTN(chosenIndex, 1);
    prompt = ['Choose a value for variable ', num2str(absoluteIndex), ...
                        ' in the range of ', num2str(minValue), ...
                        ' and ', num2str(maxValue), '? '];
               
    if minValue == maxValue % If the min == max, we choose     
        inputValue = minValue;
        disp(['The variable ', num2str(absoluteIndex), ' is assigned to it''s only possible value ', num2str(inputValue), '.']);
    elseif isAutomatic == 1 % Let the computer choose
        inputValue = randi([minValue, maxValue]); 
        disp([prompt, num2str(inputValue)]);
    else % Let the user choose
        inputValue = input(prompt);
    end
    
    while inputValue < minValue || inputValue > maxValue % Valid input?
        disp('You value isn''t in the given range');
        inputValue = input(prompt);
    end
    
    outputSTN = insertValue(inputSTN, chosenIndex, inputValue); % Calculate everything

    
end
