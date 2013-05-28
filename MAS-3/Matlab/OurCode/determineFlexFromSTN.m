function [solutions, flexibility] = determineFlexFromSTN(stn)
    % Determine a solution and a freedom for a given stn.
    
   [sizeSTN, ~] = size(stn);
   
   [A, b, lb, ub] = createAForFlex(stn);
   % The minimalisation function is [1, -1, 1, -1..]
   f = linspace(1, 2*(sizeSTN-1), 2*(sizeSTN-1));
   f = 2*mod(f,2) -1;

   solutions = linprog(f,A,b, [], [], lb, ub);
   flexibility = -f*solutions 
end

