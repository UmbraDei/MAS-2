% Try to split the problem and calculate the flexibility.

%% 4 constraints between the 2 blocks!
t1M = [3, 8, 6, 10];
t2M = [8, 3, 10, 6];
tStrings = { 'a'; ... %1
        'TP^C_{ST}'; ... %2
        'TP^C_{ET}'; ... %3
        'L^C_{ST}'; ... %4 
        'L^C_{ET}'; ... %5
        'R^A_{ST}'; ... %6
        'R^A_{ET}'; ... %7
        'TR^A_{ST}'; ... %8
        'TR^A_{ET}'; ... %9
        'R^B_{ST}'; ... %10
        'R^B_{ET}'; ... %11
        'W^B_{ST}'; ... %12
        'W^B_{ET}'}; %13
    
%% Calculate the STN and flex
stn = opstellenSTN6a();
[oplossing, flex] = determineFlexFromSTN(stn);
oplossing = round(oplossing); %Round to remove small inconsistenties 
            % (t_i^+ - t_i^- is sometimes smaller as 0 (e.g. -10^-12) by
            % rounding errors

%% Add the constraints
for i = 1:4
    % t_index1 - t_index2 <= ...
    index1 = t1M(1, i);
    index2 = t2M(1, i);
    constraint1 = oplossing(2*(index1-1)); %v_index1+
    constraint2 = -oplossing(2*(index2-1)-1) ;%v_index2-
    stn(1, index1) = constraint1;
    stn(index2, 1) = constraint2;
    disp(['Extra constraint: ', tStrings{index1,1}, ' - z_0 <= ', num2str(constraint1)]); 
    disp(['Extra constraint: z_0 - ', tStrings{index2,1}, ' <= ', num2str(constraint2)]); 
end

%% Calculate new flex as control
[oplossing3, flex3] = determineFlexFromSTN(stn);

