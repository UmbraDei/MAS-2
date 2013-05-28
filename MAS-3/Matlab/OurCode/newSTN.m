function output = newSTN(matrix, constraints)
    [nbOfContraints, check] = size(constraints);
    
    if check ~=3 
        error('newSTN', 'Fault arguments');
    end
    
    for i = 1:nbOfContraints
        % t - t2 <= delta
        t = constraints(i,1);
        t2 = constraints(i,2);
        delta = constraints(i,3);
        %% Check consistency
        if delta < -matrix(t, t2)
            output = 'Inconsistent';
            return
        end

        %% Change the other element
        matrix(t2, t) = delta;
    end
    output = FastFloyd(matrix);
    
    if sum(abs(diag(output)));
        output = 'Inconsistent';
    end 
end
    