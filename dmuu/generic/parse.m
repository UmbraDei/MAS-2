function [T] = parse(fname)
% function [T] = parse(FILE)
%
% Parses the connection file FILE into a transition matrix T.

init;

DIR_ARRAY = 'NSEW';

% -- Parse file name, to make sure it includes extension -- %

if ( isempty(find(fname == '.', 1)) )

    fname = sprintf('%s.con', fname);  % If no extension, adds extension

end

% -- Open file for reading -- %

f=fopen(fname,'r');

% -- Initialize auxiliary variables -- %

nLine   = 0;      % Line counter;
newline = [];     % Line reader
nR      = 0;      % Stores the number of rooms in current environment
Taux    = [];     % Auxiliary transition matrix: T(k, :) = [rN, rS, rE, rW ]
                  % where rN, rS, rE and rW are the rooms at the north, 
                  % south, east and west of room k.

% -- Parse the file line by line -- %
newline=fgetl(f); 
while (isempty(newline) || any(newline ~= -1))
    
    newline=upper(newline);   % Read line

    nLine = nLine + 1;    % Incremented line counter
    
    % If line is not empty or is not a comment, proceed.
    
    if (~isempty(newline) && newline(1) ~= '%')
        
        % If line defines the current number of rooms, proceed
        
        if (newline(1) == 'R')

            nR = str2double(newline(2:end));    % Initialize nR            
            Taux = (1:nR)' * ones(1,4);         % Initialize Taux with 
                                                % default transitions
           
        else
            if (nR == 0)    % If number of rooms not parsed so far
                error('Error parsing %s: Number of rooms undefined in line %i.', fname, nLine);
            end
            
            % -- Computes direction of connection in current line -- %
            
            c_pos = [];     % Position of the direction char in the line 
            d = 0;          % Actual direction
            
            while (isempty(c_pos) && d < 4)
                d = d + 1;
                c_pos = find(newline == DIR_ARRAY(d));    % Checks if 
                                                        % current direction
                                                        % appears in line
            end
            
            % If some direction appears (i.e., if the line is not messed
            % up, fills in the auxiliary transition matrix accordingly
            
            if (~isempty(c_pos))
                i = str2double(newline(1:(c_pos - 1)));   % Initial room
                j = str2double(newline((c_pos + 1):end)); % Final room
                Taux(i, d) = j;                           % Update matrix
            end
        end
    end
    newline=fgetl(f); 
end

% -- Output statistics -- %

if (ECHO)
    fprintf(1, 'PARSE >> Parsing of file %s complete.\n', fname);
    fprintf(1, 'PARSE >> Parsed %i lines.\n', nLine);
end

% -- Create actual transition matrix -- %

% Standard initialization

pCorrect=0.95;

T = (1-0.95) * eye(nR);
T(:, :, 2) = T(:, :, 1);
T(:, :, 3) = T(:, :, 1);
T(:, :, 4) = T(:, :, 1);

% Spools through auxiliary matrix and corrects probabilities

for i = 1:nR
    T(i, Taux(i, 1), 1) = T(i, Taux(i, 1), 1) + pCorrect;
    T(i, Taux(i, 2), 2) = T(i, Taux(i, 2), 2) + pCorrect;
    T(i, Taux(i, 3), 3) = T(i, Taux(i, 3), 3) + pCorrect;
    T(i, Taux(i, 4), 4) = T(i, Taux(i, 4), 4) + pCorrect;
end    
