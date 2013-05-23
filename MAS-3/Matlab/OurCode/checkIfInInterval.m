function output = checkIfInInterval(interval1, interval2)
    if interval1(1,1) >= interval2(1,2) 
        output = 0;
    elseif interval1(1,2) <= interval2(1,1) 
        output = 0;
    else
        output = 1;
    end
end