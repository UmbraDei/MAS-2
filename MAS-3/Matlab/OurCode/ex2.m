% This script will add constraints to a given stn and check if it is still
% valid afterwards.

O = loadMatrix(5)
O1 = newSTN(O, [3, 2, 0]) 
O2 = newSTN(O, [1, 4, 1]);
change_O2 = sum(sum(abs(O2))) - sum(sum(abs(O)))

A = loadMatrix(49);
A1 = newSTN(A, [20, 26, -7000])
A2 = newSTN(A, [42, 41, 9000]);
change_A2 = sum(sum(abs(A2))) - sum(sum(abs(A)))
A3 = newSTN(A, [42, 41, 9000; 14, 16, 500]);
change_A3 = sum(sum(abs(A3))) - sum(sum(abs(A)))
A4 = newSTN(A, [42, 41, 9000; 41, 42, -5000])