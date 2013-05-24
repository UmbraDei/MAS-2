function [countTimings, planesTogether, outputstn]  = calculateNbOfRunways(inputMatrix)
    %% Creating matrix
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
    
    [countTimings, planesTogether] = shavePeak(tempOutputSTN, sizeInput);
    
    %% 
    while sum(abs(diag(tempOutputSTN))) == 0
        
        outputstn = tempOutputSTN;
        [countTimings, planesTogether] = shavePeak(tempOutputSTN, sizeInput);
        peak = getEarliestPeaks(countTimings, planesTogether);
        % add constraint
        tempOutputSTN = addConstraintForPeak(outputstn, peak);
        disp(['Lusje aan het lopen: ', num2str(max(countTimings)), ' with first timing at ', num2str(peak{1,1}(1,2))]);
    end

end

function [countTimings, planesTogether] = calculateNbOfConcurrentPlanes(leavingTimePlane, sizeInput, timings)
    countTimings = zeros(sizeInput, 1);
    planesTogether = cell(sizeInput, 1);
    
    for i=1:sizeInput
        index = leavingTimePlane(i,1);
        
        timingPlane1 = [timings(3*(index-1)+3, 1), timings(3*(index-1)+4, 1)];
        
        planesTogether{index, 1} = cell(0,0);
        
        for j = i:sizeInput
            interIndex = leavingTimePlane(j,1);
            timingPlane2 = [timings(3*(interIndex-1)+3, 1), timings(3*(interIndex-1)+4, 1)];
            isInInterval = checkIfInInterval(timingPlane1, timingPlane2); 
            
            countTimings(index, 1) = countTimings(index, 1) + isInInterval;
            
            if isInInterval == 1
                planesTogether{index, 1} = [planesTogether{index,1}, {[interIndex, timings(3*(interIndex-1)+3, 1), timings(3*(interIndex-1)+4, 1)]}];
            end
        end
    end
end

function earliestPeak = getEarliestPeaks(countTimings, planesTogether)
    [~, index] = max(countTimings);
    earliestPeak = planesTogether{index, 1};
end

function outputstn = addConstraintForPeak(inputstn, peak)
    
    [~, peakSize] = size(peak);
    latestTiming = zeros(peakSize, 1);
    %% Select most freedom
    for i = 1:peakSize
        index = peak{1, i}(1,1);
        latestTiming(peakSize-i+1, 1) = inputstn(1, 3*(index-1)+3); % geinverteerd opslaan van de laatste timing
    end
    
    [~, latestIndex] = max(latestTiming);
    latestIndex = peakSize - latestIndex +1; %geinverteerde matrix
    
    %%
    firstPlane = 1;
    if latestIndex == 1
        firstPlane = 2;
    end
    
    delayedPlaneIndex = peak{1, latestIndex}(1,1);
    firstPlaneIndex = peak{1, firstPlane}(1,1);
    outputstn = newSTN(inputstn, 3*(firstPlaneIndex-1)+3, 3*(delayedPlaneIndex-1)+3, -5);
end

function [countTimings, planesTogether] = shavePeak(outputstn, sizeInput)
    % Earliest timings
    timings = -outputstn(:,1);
    
    leavingTimePlane = zeros(sizeInput, 2);
    for i = 1:sizeInput
        leavingTimePlane(i,:) = [i, timings(3*i, 1)];
    end
    
    leavingTimePlane = sortrows(leavingTimePlane, 2);
    [countTimings, planesTogether] = calculateNbOfConcurrentPlanes(leavingTimePlane, sizeInput, timings);
end 