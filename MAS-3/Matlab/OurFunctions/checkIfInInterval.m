function output = checkIfInInterval(interval1, interval2)
    % Check if the 2 time intervals have an overlap (0 == false, 1 == true)
    
    if interval1(1,1) >= interval2(1,2) %starting from 1 after finalizing of 2
        output = 0;
    elseif interval1(1,2) <= interval2(1,1) %starting from 2 after finalizing of 1
        output = 0;
    else
        output = 1;
    end
end