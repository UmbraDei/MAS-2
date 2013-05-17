function outputSTN = insertValue(inputSTN, index, value)

    inputSTN(1, index) = value;
    inputSTN(index, 1) = -value;
    pink = inputSTN;
    outputSTN = FastFloyd(pink);
    
    %Assert everything is still alright
    if sum(abs(diag(outputSTN)))> 0
        error('STN:NonZeroDiag', 'ERROR: non zero elements on the diagonal');
    end
    
    outputSTN(index,:) = [];
    outputSTN(:, index) = [];
    
end
    
    