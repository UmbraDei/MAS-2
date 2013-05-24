 O = loadMatrix(5)
 O1 = newSTN(O, 3, 2, 0) 
 O2 = newSTN(O, 1, 4, 1);
 change_O2 = sum(sum(abs(O2))) - sum(sum(abs(O)))
 
 A = loadMatrix(49);
 A1 = newSTN(A, 20, 26, -7000)
 A2 = newSTN(A, 42, 41, 9000);
 change_A2 = sum(sum(abs(A2))) - sum(sum(abs(A)))