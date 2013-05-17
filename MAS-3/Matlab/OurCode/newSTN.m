function output = newSTN(matrix, t, t2, delta)
    % t - t2 <= delta


    %% Check consistency
    if delta < -matrix(t, t2)
        output = 'Inconsistent';
        return
    end
    
    %% Change the other element
    matrix(t2, t) = delta;
    output = FastFloyd(matrix);
    