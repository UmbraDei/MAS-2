% INIT File
% 
% Initializes constants used throughout the functions in this setting.
% These constants are all named with all-caps and using underscores to
% separate words. Current constants are:
%
% . ECHO         - Flag to enable/disable algorithm output
% . RUN_MAX      - Maximum number of iterations per run in tests
% . AVG_MAX      - Maximum trials for averaging in tests
% . C_ARRAY      - Color array, used to plot different colors in
%                  multi-agent settings
% . WBAR_OK      - Minimum number of iterations for which a waitbar should 
%                  be used
% . VERB         - Flag to enable/disable verbatim algorithm runs
% . IND_REWARD   - Reward for reaching individual goal
% . COORD_REWARD - Joint reward for coordination
% . EPS          - Error threshold/stopping condition
% . DELTA        - Mixture coefficient
% Environment variables

ECHO = 0;
RUN_MAX = 250;
AVG_MAX = 1000;
C_ARRAY = 'bgrcmyk';
WBAR_OK = 10;
VERB    = 1;

% Initialization constants

IND_REWARD = 1;
COORD_REWARD = -20;

% Algorithmic parameters

EPS = 0.01;
DELTA = 0.2;
