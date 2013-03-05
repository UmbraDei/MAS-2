function initProblem
% Problem specific initialization function for Hallway2.
% $Id: initProblem.m,v 1.10 2004/09/20 15:03:53 mtjspaan Exp $

clear global pomdp;
global problem;
global pomdp;

% String describing the problem.
problem.description='Hallway2';

% String used for creating filenames etc.
problem.unixName='hallway2';

% Load the (cached) .POMDP, defaults to unixName.POMDP.
initPOMDP;

% Generic POMDP initialization code. Should be called after initPOMDP.
initProblemGeneric;

% Hallway2.POMDP does not list the action by name, so we provide them
% here.
problem.actions=char('Stay in place','Move forward','Turn right',['Turn ' ...
                    'around'],'Turn left');
