function [GammaAO,GammaAOS,GammaAOnew] = computeGammaAO(V0)
% computeGammaAO - compute the backprojected vectors from t+1
%
% [GammaAO,GammaAOS] = computeGammaAO(V0)
%
% V0 - struct array of alpha vectors
%
% GammaAO  - size(V0){nrA}{nrO} backprojected copies from V0
% GammaAOS - sparse(GammaAO)

% Author: Matthijs Spaan
% $Id: computeGammaAO.m,v 1.7 2004/07/14 14:51:15 mtjspaan Exp $
% Copyright (c) 2003,2004 Universiteit van Amsterdam.  All rights reserved.
% More information is in the file named COPYING.

global problem;

nrA=problem.nrActions;
nrO=problem.nrObservations;
nrS=problem.nrStates;

[nrInV,foo]=size(V0);
V0v=vertcat(V0.v);

if ~problem.useSparse
  transition=problem.transition;
  observation=problem.observation;
end
gamma=problem.gamma;

start=cputime;

% Step 1
for a=1:nrA
  if problem.useSparse
    transition=problem.transitionS{a};
  end
  if problem.useSparseObs
    observation=problem.observationS{a};
  else
    observation=problem.observation{a};
  end
  for o=1:nrO
    if problem.useSparse
      storage=zeros(fix(0.5*nrInV*nrS),3);
      nnzEntries=0;
      for k=1:nrInV
         [I,J,S]=find(sum(gamma*transition'*(observation(:,o).* ...
                                             V0v(k,:)'),2)');
         sz=size(I);
         I=repmat(k,sz);
         bottom=nnzEntries+1;
         top=bottom+sz(2)-1;
         storage(bottom:top,1)=I';
         storage(bottom:top,2)=J';
         storage(bottom:top,3)=S';
         nnzEntries=top;
      end
      GammaAOS{a}{o}=sparse(storage(1:nnzEntries,1), ...
                           storage(1:nnzEntries,2), ...
                           storage(1:nnzEntries,3), ...
                           nrInV, nrS);
      GammaAO{a}{o}=full(GammaAOS{a}{o});
    else
      GammaAO{a}{o}=zeros(nrInV,nrS);
      for k=1:nrInV
        for s1=1:nrS
          GammaAO{a}{o}(k,:)=GammaAO{a}{o}(k,:) + ...
              gamma*transition(s1,:,a)* ...
              observation(s1,a,o)*V0v(k,s1);
        end
      end
    end
  end
end

fprintf('computeGammaAO: took %f s\n',cputime-start);
