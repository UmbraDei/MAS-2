function dividedPlanes = dividePlanes(timings, nbOfRunways)
% Divide the planes over a number of runways given timings and the nb of
% runways.

    % Select the right leaving times.
   [sizeInput, ~] = size(timings);
   sizeInput = (sizeInput-1)/3;
   leavingTimePlane = zeros(sizeInput, 2);
   for i = 1:sizeInput
       leavingTimePlane(i,:) = [i, timings(3*i, 1)];
   end
   
   %Sort on size and divide over the runways
   leavingTimePlane = sortrows(leavingTimePlane, 2);
   extraColumn = transpose(mod(linspace(0,sizeInput-1, sizeInput),nbOfRunways)+ones(1, sizeInput)); % this will give [1, 2, 3, 1, 2, 3] for 3 runways
   leavingTimePlane = [leavingTimePlane extraColumn] ;
  
   
   %% Check if the solution is valid
   for i = 1:sizeInput-nbOfRunways
       if leavingTimePlane(i,2) + 5 > leavingTimePlane(i+nbOfRunways,2)
           error('dividePlanes', 'Not enough interleaving time');
       end
   end
   
   inputFile = loadFile();

   %% Initiate the values for the constraints
   nbOfEquations = 6*sizeInput - nbOfRunways;
   b = zeros(nbOfEquations, 1);
   A = zeros(nbOfEquations, 4*sizeInput);
   
   %% Create the constraints for takeoff and departure time
   currentEquation = 1;
   for i = 1:sizeInput
      % + 1: t_dep-, +2: t_dep+, +3, +4
      % - t_dep- <= -depTime
      [A, b, currentEquation] = fillInEquationSingle(A, b, currentEquation, 4*(i-1) + 1, -1, - inputFile(i,2));
       
      % t_take+ <= takeTime
      [A, b, currentEquation] = fillInEquationSingle(A, b, currentEquation, 4*(i-1) + 4, 1, inputFile(i,3));
    
      % -t_takeoff- + t_dep+ <= -20
      [A, b, currentEquation] = fillInEquation(A, b, currentEquation, 4*(i-1) + 3, -1, 4*(i-1) + 2, 1, -20);
      
      %t_dep- - t_dep+ <= 0
      [A, b, currentEquation] = fillInEquation(A, b, currentEquation, 4*(i-1) + 1, 1, 4*(i-1) + 2, -1, 0);
      %t_take- - t_take+ <= 0
      [A, b, currentEquation] = fillInEquation(A, b, currentEquation, 4*(i-1) + 3, 1, 4*(i-1) + 4, -1, 0);
      
      %t_take- - t_take+ <= 0
      %[A, b, currentEquation] = fillInEquation(A, b, currentEquation, 4*(i-1) + 3, 1, 4*(i-1) + 4, -1, 0);
   end
   
   %% Plan the planes on their own runway (with at least 5 min between)
   for i = 1:sizeInput-nbOfRunways
       % t_take+(van i) + 5 <= t_take-(van i+nbOfRunways)
       plane1 = leavingTimePlane(i,1);
       plane2 = leavingTimePlane(i+nbOfRunways,1);
       [A, b, currentEquation] = fillInEquation(A, b, currentEquation, 4*(plane1-1) + 4, 1, 4*(plane2-1) + 3, -1, -5);
   end

   %% maximise.
   f = linspace(1, 4*sizeInput, 4*sizeInput);
   f = 2*mod(f,2) -1;
   lb = min(inputFile(:,2))*ones(4*sizeInput, 1);
   ub = max(inputFile(:,3))*ones(4*sizeInput, 1);

   dividedPlanes = linprog(f,A,b);
   freedom = -f*dividedPlanes
   nbOfEquations
   currentEquation;
end 

function [A, f, currentEquation] = fillInEquationSingle(A, f, currentEquation, valuePlace1, value1, rightSide)
    % Create constraint for a single value at a given place
    A(currentEquation, valuePlace1) = value1;
    f(currentEquation, 1) = rightSide;
    currentEquation = currentEquation + 1;
end

function [A, f, currentEquation] = fillInEquation(A, f, currentEquation, valuePlace1, value1, valuePlace2, value2, rightSide)
    % Create constraint for a 2 values at the given places
    A(currentEquation, valuePlace1) = value1;
    A(currentEquation, valuePlace2) = value2 ;
    f(currentEquation, 1) = rightSide;
    currentEquation = currentEquation + 1;
end