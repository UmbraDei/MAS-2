function pomdpToProblem
% pomdpToProblem - copies a global pomdp struct to a global problem one

% Author: Matthijs Spaan
% $Id: pomdpToProblem.m,v 1.3 2004/07/13 13:59:32 mtjspaan Exp $
% Copyright (c) 2003,2004 Universiteit van Amsterdam.  All rights reserved.
% More information is in the file named COPYING.

global pomdp;
global problem;

members=fieldnames(pomdp);
[n,foo]=size(members);

for i=1:n
  problem.(char(members([i])))=pomdp.(char(members([i])));
end

% check whether there might be an old start distribution present
if isfield(problem,'start') & ~isfield(pomdp,'start')
  problem=rmfield(problem,'start');
  problem=rmfield(problem,'startCum');
end
