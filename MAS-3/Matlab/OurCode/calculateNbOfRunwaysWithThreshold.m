function [keepGoing, outputstn]  = calculateNbOfRunwaysWithThreshold(inputMatrix, threshold)
    %% Creating matrix
    % +1: t_dep, +2: t_takeoff, +3: t_free
    [sizeInput,~] = size(inputMatrix);

    stnmatrix = 10000*(ones(1 + 3*sizeInput, 1 + 3*sizeInput) - diag(ones(1 + 3*sizeInput,1)));
    
    for i=1:sizeInput
       stnmatrix(3*(i-1)+2, 1) = - inputMatrix(i,2);
       stnmatrix(3*(i-1)+3, 3*(i-1)+2) = -20; 
       stnmatrix(3*(i-1)+4, 3*(i-1)+3) = -5; 
       stnmatrix(3*(i-1)+3, 3*(i-1)+4) = 5; 
       stnmatrix(1, 3*(i-1)+3) = inputMatrix(i,3); 
    end
    
    %% Initial solving (infinite runways)
    tempOutputSTN = FastFloyd(stnmatrix);
    
    keepGoing = 1;
    %% 
    while keepGoing == 1
        
        outputstn = tempOutputSTN;
        peak = getPeakAboveThreshold(tempOutputSTN, sizeInput, threshold);
        if iscell(peak) == 0
            keepGoing = 2;
            disp(['Lusje aan het lopen en klaar']);
        else
            % add constraint
            tempOutputSTN = addConstraintForPeak(outputstn, peak, threshold);
            if sum(abs(diag(tempOutputSTN))) ~= 0
                keepGoing = 3;
            end
            disp(['Lusje aan het lopen: with first timing at ', num2str(peak{1,1}(1,2))]);
        end
        
    end

end

function peak = getPeakAboveThreshold(outputstn, sizeInput, threshold)
    % Earliest timings
    timings = -outputstn(:,1);
    
    leavingTimePlane = zeros(sizeInput, 3);
    for i = 1:sizeInput
        leavingTimePlane(i,:) = [i, timings(3*i, 1), timings(3*i+1, 1)];
    end
    
    leavingTimePlane = sortrows(leavingTimePlane, 2);
    peak = getFirstBeakAboveThreshold(leavingTimePlane, sizeInput, threshold);
end 

function planesTogether = getFirstBeakAboveThreshold(leavingTimePlane, sizeInput, threshold)
    
    for i=1:sizeInput
        timingPlane1 = leavingTimePlane(i,2:3);
        countTimings = 0;
        
        planesTogether = cell(0,0);
        
        for j = i:sizeInput
            timingPlane2 = leavingTimePlane(j,2:3);
            isInInterval = checkIfInInterval(timingPlane1, timingPlane2); 
            
            countTimings = countTimings + isInInterval;
            
            if isInInterval == 1
                planesTogether = [planesTogether, {leavingTimePlane(j,1:3)}];
            end
        end
        
        if countTimings > threshold
            return;
        end
    end
    planesTogether = 0;
end



function outputstn = addConstraintForPeak(inputstn, peak, threshold)
    
    [~, peakSize] = size(peak);
    latestTiming = zeros(peakSize, 2);
    %% Select most freedom
    for i = 1:peakSize
        index = peak{1, i}(1,1);
        latestTiming(peakSize-i+1, :) = [index, inputstn(1, 3*(index-1)+3)]; % geinverteerd opslaan van de laatste timing
    end
    
    latestTiming = sortrows(latestTiming, 2);
    constraints = zeros(peakSize-threshold,3);
    for i = threshold+1:peakSize
        constraints(i-threshold,:) = [3*(latestTiming(1,1)-1)+3, 3*(latestTiming(i,1)-1)+3, -5];
    end
    
    outputstn = newSTN(inputstn, constraints);
end

