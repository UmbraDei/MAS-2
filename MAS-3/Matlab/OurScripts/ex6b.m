% Create the stn for 5b and calculate the flexibility
stn = opstellenSTN6b();
[oplossing, flex] = determineFlexFromSTN(stn);