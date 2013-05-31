function outputSTN = insertValue(inputSTN, index, value)
    % Insert a value in an stn
    
    inputSTN(1, index) = value;
    inputSTN(index, 1) = -value;
    pink = inputSTN;
    outputSTN = FastFloyd(pink);
    
    %Assert everything is still alright
    if sum(abs(diag(outputSTN)))> 0
        error('STN:NonZeroDiag', 'ERROR: non zero elements on the diagonal');
    end
    
    % remove the given column and row
    outputSTN(index,:) = [];
    outputSTN(:, index) = [];
    
end
    
    