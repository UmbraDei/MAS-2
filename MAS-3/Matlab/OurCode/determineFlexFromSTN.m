function [solutions, freedom] = determineFlexFromSTN(stn)
   [sizeSTN, ~] = size(stn);
   
   [A, b, lb, ub] = createAForFlex(stn);
   f = linspace(1, 2*(sizeSTN-1), 2*(sizeSTN-1));
   f = 2*mod(f,2) -1;

   solutions = linprog(f,A,b, [], [], lb, ub);
   freedom = -f*solutions
end

