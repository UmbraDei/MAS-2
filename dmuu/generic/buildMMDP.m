function [M,Pind,Rind] = buildMMDP(MG)

init;

% Build MDP

nS1 = MG.M1.nS;
nS2 = MG.M2.nS;
nA1 = MG.M1.nA;
nA2 = MG.M2.nA;

nS = nS1 * nS2;
nA = nA1 * nA2;
nI = MG.nI;
gm = MG.M1.gamma;

P  = cell(nA, 1);
R  = zeros(nS, nA);

Rind{1}=MG.M1.r;
Rind{2}=MG.M2.r;
Pind{1}=MG.M1.P;
Pind{2}=MG.M2.P;

for a = 1:nA
    [a1, a2] = ind2sub([nA1 nA2], a);
    P{a} = kron(MG.M2.P(:,:,a2), MG.M1.P(:,:,a1));
    R1 = repmat(MG.M1.r(:, a1), 1, nS2);
    R2 = repmat(MG.M2.r(:, a2)', nS1, 1);
    
    R(:, a) = R1(:) + R2(:);
end

% Compute coordination rewards
C  = [];

for I = 1:nI
    C = [C [MG.MI{I}.C;MG.MI{I}.C]];
end

C  = C';
C = sub2ind([nS1, nS2], C(:,1), C(:,2));

% Compute global reward
R(C,:) = R(C,:) + COORD_REWARD;

% Compute initial state

X0 = sub2ind([nS1, nS2], MG.M1.X0, MG.M2.X0);


M = struct('nS', nS, 'nA', nA, 'P', {P}, 'r', R, 'gamma', gm, 'X0', ...
           X0);

