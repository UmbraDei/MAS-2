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
freedom1 = -f1*oplossing1

oplossing2 = linprog(f2, A, b, flexOverAll, -flex, lb, ub);
freedom2 = -f2*oplossing2

oplossing3 = linprog(f3, A, b, flexOverAll, -flex, lb, ub);
freedom3 = -f3*oplossing3

% With 2 as max flex 30, we cannot destribute the flexibility more.