function [MDP] = MDPStruct(Model, Goal, X0, varargin)
% function [MDP] = MDPStruct(Model, Goal, X0)
% function [MDP] = MDPStruct(Model, Goal, X0, Label)
%
% Creates an MDP struct with the environment corresponding to Model. 

init;

% -- Array with possible file names -- %

MDL = {'room_21.con';'room_36.con';'CIT.con';'CMU.con';'ISR.con';'MIT.con';'SUNY.con'; 'room_20.con'};

% -- Compute transition matrix from connection file -- %

if (Model > 0 && Model < 10)

    P = parse(MDL{Model});

else

    error('Invalid model number in MDPStruct().');

end

% -- Compute problem dimensions from transition matrix -- %

nS = size(P(:,:,1), 1);
nA = size(P,3);

% -- Compute reward function from provided goal -- %

r = zeros(nS, nA);
r(Goal, :) = IND_REWARD;

% Initialize other variables

gm = 0.95;

% -- Create labeled MDP structure -- %

if (nargin > 3)
    label = upper(varargin{1});
else
    label = 'DEFAULT';
end

MDP = struct('nS', nS, 'nA', nA, 'P', {P}, 'r', r, 'gamma', gm, 'X0', X0, 'Model', Model, 'Label', label);
