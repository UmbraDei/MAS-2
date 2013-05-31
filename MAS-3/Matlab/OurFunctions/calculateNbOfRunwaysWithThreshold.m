function [keepGoing, outputstn]  = calculateNbOfRunwaysWithThreshold(inputMatrix, threshold)
    % Checks for the given inputMatrix and threshold if it is possible to
    % create a solution. As returnvalue, the keepGoing is the status (2 =
    % OK, 3 means possible)
    % If it is possible, the outputstn will contain a stn that gives a
    % valid solution if for the ealiest timings. 

    %% Creating matrix
    % +1: t_dep, +2: t_takeoff, +3: t_free
    [sizeInput,~] = size(inputMatrix);
    % The creation of the matrix
    stnmatrix = 10000*(ones(1 + 3*sizeInput, 1 + 3*sizeInput) - diag(ones(1 + 3*sizeInput,1)));
    
    for i=1:sizeInput
        % The different constraints of the matrx
       stnmatrix(3*(i-1)+2, 1) = - inputMatrix(i,2); %minimal departure time
       stnmatrix(3*(i-1)+3, 3*(i-1)+2) = -20; % Takeoff 20min after departure
       stnmatrix(3*(i-1)+4, 3*(i-1)+3) = -5; % Block runway minimimum 5min
       stnmatrix(3*(i-1)+3, 3*(i-1)+4) = 5; % Block runway maximum 5min
       stnmatrix(1, 3*(i-1)+3) = inputMatrix(i,3); % maximal takeoff time
    end
    
    %% Initial solving (infinite runways)
    tempOutputSTN = FastFloyd(stnmatrix);
    
    % Keep going
    keepGoing = 1;
    
    %% Loop to find solution less as the threshold
    while keepGoing == 1
        
        outputstn = tempOutputSTN;
        peak = getPeakAboveThreshold(tempOutputSTN, sizeInput, threshold);
        % If the peak is no cell, a solution with less or equal as the
        % threshold is found.
        if iscell(peak) == 0
            keepGoing = 2;
            disp(['Loop was running and a solution is found.']);
        else
            if peak{1,1}(1,2) == 923
                'Debug'
            end
            % Add constraints to eliminate the peak
            tempOutputSTN = addConstraintForPeak(outputstn, peak, threshold);
            [~, nbOfElementsInPeak] = size(peak);
            disp(['Loop is running and arrived at timining ', num2str(peak{1,1}(1,2)), ' with ', num2str(nbOfElementsInPeak), ' constraints.']);
            if ischar(tempOutputSTN) % Check if matrix is still valid
                keepGoing = 3;
                outputstn = tempOutputSTN;
                disp(['Loop was running and no possible solution.']);
            end
            
            
        end
        
    end

end

function peak = getPeakAboveThreshold(outputstn, sizeInput, threshold)
    % Get the first peak above the threshold from the given outputstn
    
    % Earliest timings scheduling
    timings = -outputstn(:,1);
    %% Reorganizing the leaving times.
    leavingTimePlane = zeros(sizeInput, 3);
    for i = 1:sizeInput
        leavingTimePlane(i,:) = [i, timings(3*i, 1), timings(3*i+1, 1)];
    end
    
    leavingTimePlane = sortrows(leavingTimePlane, 2);
    
    %% Find the preak with the reorganized input
    peak = getFirstBeakAboveThreshold(leavingTimePlane, sizeInput, threshold);
end 

function planesTogether = getFirstBeakAboveThreshold(leavingTimePlane, sizeInput, threshold)
    % Get the first peak above the threshold from the given departure time
    %% Go over all the input
    for i=1:sizeInput
        % When does the plane leaves
        timingPlane1 = leavingTimePlane(i,2:3);
        countTimings = 0;
        
        planesTogether = cell(0,0);
        
        % Count all planes starting from this one within the given time
        for j = i:sizeInput
            timingPlane2 = leavingTimePlane(j,2:3);
            isInInterval = checkIfInInterval(timingPlane1, timingPlane2); 
            
            countTimings = countTimings + isInInterval;
            
            if isInInterval == 1
                planesTogether = [planesTogether, {leavingTimePlane(j,1:3)}];
            end
        end
        
        % If the peak is higher as threshold, return
        if countTimings > threshold
            return;
        end
    end
    %% Nothing found, return 0
    planesTogether = 0;
end



function outputstn = addConstraintForPeak(inputstn, peak, threshold)
    % Add constraints at the stn for a given peak above the threshold.
    
    [~, peakSize] = size(peak);
    latestTiming = zeros(peakSize, 2);
    %% Rearrange the input
    for i = 1:peakSize
        index = peak{1, i}(1,1);
        latestTiming(i, :) = [index, inputstn(1, 3*(index-1)+3)]; 
    end
    
    %% Add extra column, smaller for less freedom (earlier latest takeoff time of
    %  if the takeoff time is the same, the one with the earliest possible
    %  takeoff is earlier)
    sortingColumn = latestTiming(:,1) + latestTiming(:,2)*max(latestTiming(:,1));
    
    latestTiming = [latestTiming sortingColumn];
    latestTiming = sortrows(latestTiming, 3);
    constraints = zeros(peakSize-threshold,3);
    
    %% Everything further as the threshold, has to be delayed. Herefore add constraints
    for i = threshold+1:peakSize
        constraints(i-threshold,:) = [3*(latestTiming(1,1)-1)+3, 3*(latestTiming(i,1)-1)+3, -5];
    end
    %% Add constraints to STN
    outputstn = newSTN(inputstn, constraints);
end

