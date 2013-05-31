% Calculate everything for STN and try to 

%% Caculate the flex
stn = opstellenSTN6a();
[oplossing, flex] = determineFlexFromSTN(stn);

%% Calculate the flexibilities on each individual component
[sizeSTN, ~] = size(stn);
   
[A, b, lb, ub] = createAForFlex(stn);
flexOverAll = linspace(1, 2*(sizeSTN-1), 2*(sizeSTN-1));
flexOverAll = 2*mod(flexOverAll,2) -1;

% the flex on the 3 components
f1 = [flexOverAll(1,1:2*(sizeSTN-1)/3), zeros(1, 2*(sizeSTN-1)*2/3)];
f2 = [zeros(1, 2*(sizeSTN-1)*1/3), flexOverAll(1,1:2*(sizeSTN-1)/3), zeros(1, 2*(sizeSTN-1)*1/3)];
f3 = [zeros(1, 2*(sizeSTN-1)*2/3), flexOverAll(1,1:2*(sizeSTN-1)/3)];

ANew = [A;flexOverAll];
bNew = [b;-flex];

%% Try to divide the flex
oplossing1 = linprog(f1, A, b, flexOverAll, -flex, lb, ub);
flexibility1 = -f1*oplossing1

oplossing2 = linprog(f2, A, b, flexOverAll, -flex, lb, ub);
flexibility2 = -f2*oplossing2

oplossing3 = linprog(f3, A, b, flexOverAll, -flex, lb, ub);
flexibility3 = -f3*oplossing3

% With 2 as max flex 30, we cannot destribute the flexibility more.

oplossing = linprog(flexOverAll, A, b, [f1;f2;f3], [-flexibility1;-flexibility2;-flexibility3], lb, ub);

oplossing 
flex = flexOverAll*oplossing

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
%% Add the constraints
for i = 1:4
    % t_index1 - t_index2 <= ...
    index1 = t1M(1, i);
    index2 = t2M(1, i);
    constraint1 = oplossing(2*(index1-1)); %v_index1+
    constraint2 = -oplossing(2*(index2-1)-1) ;%v_index2-
    %stn(1, index1) = constraint1;
    %stn(index2, 1) = constraint2;
    disp(['Extra constraint: ', tStrings{index1,1}, ' - z_0 <= ', num2str(constraint1)]); 
    disp(['Extra constraint: z_0 - ', tStrings{index2,1}, ' <= ', num2str(constraint2)]); 
end
