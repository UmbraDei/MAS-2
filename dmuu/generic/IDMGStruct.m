function [IDMG] = IDMGStruct(Model, GoalArray, InitArray, CrashArray)
% function [IDMG] = IDMGStruct(Model, GoalArray, InitArray, CrashArray)
%
% Creates an IDMG struct with 2 players and the environment corresponding 
% to Model. 

M1 = MDPStruct(Model, GoalArray(1), InitArray(1), 'AGENT_1');     % Create individual MDP 1
M2 = MDPStruct(Model, GoalArray(2), InitArray(2), 'AGENT_2');     % Create individual MDP 2

% -- Create joint game structure -- %

CA = CrashArray;
k  = 1;

% Determine coordination areas

S = cell(size(CA));
C = cell(size(CA));

while (~isempty(CA))
    
    % Build coordination area at first state in CrashArray
    s_new = CA(1);
    S{k} = s_new;
    C{k} = s_new;
    
    % Update CrashArray       
    CA = CA(2:end);

    % For each crash node in s_new, run over neighbors

    while (~isempty(s_new))
        
        s_curr = s_new(1);
    
        for s_conn = 1:M1.nS
        
            % If current node is connected, add to S{k}
            if (Conn(Model, [s_curr s_conn]) && ~any(s_conn == S{k}))
                S{k} = [S{k} s_conn];
                
                % If furthermore current node is a crash node, add to s_new
                % and update C
                I = find(CA == s_conn);
                if (~isempty(I))
                    s_new = [s_new s_conn];
                    C{k} = [C{k} s_conn];

                    CA = CA([1:I-1,I+1:end]);
                end
            end
        end
        
        % Update matrix of new crash nodes
        s_new = s_new(2:end);
    end
    
    S{k} = sort(S{k});
    C{k} = sort(C{k});
    
    % Move to next coordination area
    k = k+1;
end

k = k - 1;

MI = cell(1,k);

for i = 1:k
    MI{i} = struct('S', S{i}, 'C', C{i}, 'Model', Model);
end

IDMG = struct('M1', M1, 'M2', M2, 'nI', k, 'MI', {MI});