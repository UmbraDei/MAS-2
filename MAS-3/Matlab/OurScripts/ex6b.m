% Create the stn for 5b and calculate the freedom
stn = opstellenSTN6b();
[oplossing, flex] = determineFlexFromSTN(stn);