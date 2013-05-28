function outputstn = newSTN(matrix, constraints)
    % Ouput a new stn matrix afer applying the given constraints
    
    % How many constraints and is the input in the right format?
    [nbOfContraints, check] = size(constraints);
    
    if check ~=3 
        error('newSTN', 'Fault arguments');
    end
    
    %% Insert each constraints
    for i = 1:nbOfContraints
        %% Load the constraints
        % t - t2 <= delta
        t = constraints(i,1);
        t2 = constraints(i,2);
        delta = constraints(i,3);
        %% Check consistency
        if delta < -matrix(t, t2)
            outputstn = 'Inconsistent';
            return
        end

        %% Change the element in the matrix (if more restrict)
        if delta < matrix(t2, t)
            matrix(t2, t) = delta;
        end
    end
    
    %% Run FastFloyd
    outputstn = FastFloyd(matrix);
    
    %% Check the outputstn
    if sum(abs(diag(outputstn)));
        outputstn = 'Inconsistent';
    end 
end
    