function Alpha = pbSingleBackup(B,GammaAO,useSparse,GammaAOS)
% pbSingleBackup - backup a single belief point
%
% Alpha = pbSingleBackup(B,GammaAO,useSparse,GammaAOS)
%
% B         - (1 x d) single belief point to be backed up
% GammaAO   - backprojected vectors from computeGammaAO.m
% useSparse - bool, use sparse matrix computation or not
% GammaAOS  - sparse(GammaAO)
%
% Returns
% Alpha - the alpha vector of B given GammaAO[S]

% Author: Matthijs Spaan
% $Id: pbSingleBackup.m,v 1.8 2004/07/14 15:26:26 mtjspaan Exp $
% Copyright (c) 2003,2004 Universiteit van Amsterdam.  All rights reserved.
% More information is in the file named COPYING.

global problem;

nrA=problem.nrActions;
nrO=problem.nrObservations;
nrS=problem.nrStates;

[nrInV,foo]=size(GammaAO{1}{1});

% Step 2
for a=1:nrA
  for o=1:nrO
    alphaDotB{a}{o}=zeros(nrInV,1);
    alphaDotB{a}{o}=GammaAOS{a}{o}*B';
  end
end

for a=1:nrA
  tmpAlpha=zeros(1,nrS);
  for o=1:nrO
    [foo,iMax]=max(alphaDotB{a}{o});
    tmpAlpha=tmpAlpha+GammaAO{a}{o}(iMax,:);
  end
  if useSparse
    GammaAB{a}=problem.rewardS{a}'+tmpAlpha;
  else
    GammaAB{a}=problem.reward(:,a)'+tmpAlpha;
  end
end

% Step 3
val=zeros(nrA,1);
for a=1:nrA
  val(a)=GammaAB{a}*B';
end
maxActions=find(val==max(val));
aMax=maxActions(ceil(rand*length(maxActions)));
Alpha.v=GammaAB{aMax};
Alpha.a=aMax;
