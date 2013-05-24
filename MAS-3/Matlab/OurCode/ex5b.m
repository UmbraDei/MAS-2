
disp('3 runways');
A = load('Output/3planes.mat');
B = struct2cell(A);
stn = B{1,1};
timings = -stn(:,1);
dividing3 = dividePlanes(timings, 3);

disp('4 runways');
A4 = load('Output/4planes.mat');
B4 = struct2cell(A4);
stn4 = B4{1,1};
timings4 = -stn4(:,1);
dividing4 = dividePlanes(timings4, 4);

disp('207 runways');
A207 = load('Output/4planes.mat');
B207 = struct2cell(A207);
stn207 = B207{1,1};
timings207 = -stn207(:,1);
dividing207 = dividePlanes(timings207, 207);

disp('Freedom based on enough runways(207)')
timings = loadFile();
delta = timings(:,3) - timings(:,2);
sum(delta) - 207*20
