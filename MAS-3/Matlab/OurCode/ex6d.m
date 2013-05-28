 %% 4 constraints tussen de 2 blokken!
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
%% Bereken alles voor STN en flex
stn = opstellenSTN6a();
[oplossing, flex] = determineFlexFromSTN(stn);
flex = 40;

[sizeSTN, ~] = size(stn);
   
[A, b, lb, ub] = createAForFlex(stn);
flexOverAll = linspace(1, 2*(sizeSTN-1), 2*(sizeSTN-1));
flexOverAll = 2*mod(flexOverAll,2) -1;

f1 = [flexOverAll(1,1:2*(sizeSTN-1)/3), zeros(1, 2*(sizeSTN-1)*2/3)];
f2 = [zeros(1, 2*(sizeSTN-1)*1/3), flexOverAll(1,1:2*(sizeSTN-1)/3), zeros(1, 2*(sizeSTN-1)*1/3)];
f3 = [zeros(1, 2*(sizeSTN-1)*2/3), flexOverAll(1,1:2*(sizeSTN-1)/3)];

ANew = [A;flexOverAll];
bNew = [b;-flex];

%% Probeer de vrijheid eerlijk te verdelen
oplossing1 = linprog(f1, A, b, flexOverAll, -flex, lb, ub);
freedom1 = -f1*oplossing1

oplossing2 = linprog(f2, A, b, flexOverAll, -flex, lb, ub);
freedom2 = -f2*oplossing2

oplossing3 = linprog(f3, A, b, flexOverAll, -flex, lb, ub);
freedom3 = -f3*oplossing3

