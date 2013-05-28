function [A, b, lb, ub] = createAForFlex(stn)
   [sizeSTN, ~] = size(stn);
   
   [nbOfEquations, ~] = size(nonzeros(stn-10000));
   nbOfEquations = nbOfEquations - 1 - 2*(sizeSTN-1);
   
   A = zeros(nbOfEquations, 2*(sizeSTN-1));
   b = zeros(nbOfEquations, 1);
   lb = zeros(2*(sizeSTN-1), 1);
   ub = zeros(2*(sizeSTN-1), 1);
   currentEquation = 1;
   
   for i = 1:sizeSTN-1
       % -ti- <= minti
      lb(2*i-1,1) = -stn(i+1, 1);
      lb(2*i,1) = -stn(i+1, 1);
      
      % ti+ <= maxti
      ub(2*i-1,1) = stn(1, i+1);
      ub(2*i,1) = stn(1, i+1);
      
      % ti- - ti+ <= 0
      [A, b, currentEquation] = fillInEquation(A, b, currentEquation, 2*i-1, 1, 2*i, -1, 0);
   end
   
   for i = 1:sizeSTN-1
       for j = 1:sizeSTN-1
           if i ~= j && stn(i+1, j+1) < 10000
               %% t_j - t_i <= stn(i,j) => t_j- - t_i+ <= ...
               [A, b, currentEquation] = fillInEquation(A, b, currentEquation, 2*i-1, -1, 2*j, 1, stn(i+1, j+1));
           end
       end
   end
end

function [A, f, currentEquation] = fillInEquation(A, f, currentEquation, valuePlace1, value1, valuePlace2, value2, rightSide)
    A(currentEquation, valuePlace1) = value1;
    A(currentEquation, valuePlace2) = value2 ;
    f(currentEquation, 1) = rightSide;
    currentEquation = currentEquation + 1;
end