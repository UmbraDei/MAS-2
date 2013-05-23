function [timings,countTimings, planesTogether]  = calculateNbOfRunways(inputMatrix)
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
    
    runways = stnmatrix;
    %% Initial solving (infinite runways)
    outputstn = FastFloyd(stnmatrix);
    % Earliest timings
    timings = [transpose(linspace(1,1 + 3*sizeInput, 1 + 3*sizeInput)) -outputstn(:,1)];
    timings = sortrows(timings, 2);
    [countTimings, planesTogether] = calculateNbOfConcurrentPlanes(timings, sizeInput);
    
    %% 
    
        peak = getEarliestPeaks(timings, countTimings, planesTogether);
        % add constraint
        outputstn = addConstraintForPeak(outputstn, timings, peak);


end

function [countTimings, planesTogether] = calculateNbOfConcurrentPlanes(timings, sizeInput)
    countTimings = zeros(sizeInput, 1);
    planesTogether = cell(sizeInput, 1);
    
    for i=1:sizeInput
        timingPlane1 = [timings(3*(i-1)+3, 2), timings(3*(i-1)+4, 2)];
        
        planesTogether{i, 1} = cell(0,0);
        
        for j = i:sizeInput
            timingPlane2 = [timings(3*(j-1)+3, 2), timings(3*(j-1)+4, 2)];
            isInInterval = checkIfInInterval(timingPlane1, timingPlane2); 
            countTimings(i, 1) = countTimings(i, 1) + isInInterval;
            
            if isInInterval == 1
                planesTogether{i, 1} = [planesTogether{i,1}, {j}];
            end
        end
    end
end

function earliestPeak = getEarliestPeaks(timings, countTimings, planesTogether)
    maxPeaks = max(countTimings);
    [sizeInput,  ~] = size(countTimings);
    earliestTiming = 10000;

    for i=1:sizeInput
        if maxPeaks == countTimings(i, 1);
            earliestTiming = min(earliestTiming, timings(i, 1));
        end
    end
    
    for i=1:sizeInput
        if maxPeaks == countTimings(i, 1) && earliestTiming == timings(i, 1)
            earliestPeak = planesTogether{i, 1};
            return;
        end
    end
end

function outputstn = addConstraintForPeak(inputstn, timings, peak)
    
    [peakSize, ~] = size(peak);
    mostFreedom = 0;
    %% Select most freedom
    for i = 1:peakSize
        index = peak{i,1};
        mostFreedom = max(mostFreedom, timings(index, 3) - timings(index,2)); 
    end
    
    if mostFreedom > 0
        for i = 1:peakSize
            index = peak{i,1};
            if timings(index, 3) - timings(index,2) == mostFreedom
                outputstn = newSTN(inputstn, plane1, plane2, 5);
            end
        end
        
    end
    outputstn = inputstn;
end