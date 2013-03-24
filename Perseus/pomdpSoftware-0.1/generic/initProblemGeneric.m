function initProblemGeneric
% initProblemGeneric - POMDP initialization code for each problem
%
% initProblemGeneric takes a global pomdp struct and copies it to a
% problem struct. It initializes some struct members common to all
% problems and makes sure the transition, observation and reward model
% are in the desired format.

% Author: Matthijs Spaan
% $Id: initProblemGeneric.m,v 1.12 2004/09/13 09:34:30 mtjspaan Exp $
% Copyright (c) 2003,2004 Universiteit van Amsterdam.  All rights reserved.
% More information is in the file named COPYING.

global problem;

simplifyReward;
pomdpToProblem;

problem.baseDir=getDataDir;
problem.baseFilename=sprintf('%s/%s',problem.baseDir,problem.unixName);

if isfield(problem,'start');
  problem.startCum=cumsum(problem.start);
end

if isfield(problem,'reward3') | isfield(problem,'reward3S')
  problem.useReward3=1;
else
  problem.useReward3=0;
end

clear problem.beliefs;
clear problem.beliefsSP;

if problem.useSparse
  if ~isfield(problem,'useSparseObs');
    problem.useSparseObs=problem.useSparse;
  end
  if ~isfield(problem,'useSparseReward');
    problem.useSparseReward=0;
  end
  
  problem.beliefsSP=zeros(64,3);
  problem.nnzBeliefs=0;

  if ~isfield(problem,'transitionS')
    for a=1:problem.nrActions
      problem.transitionS{a}=sparse(problem.transition(:,:,a));
      problem.observationS{a}= ...
          sparse(squeeze(problem.observation(:,a,:)));
    end
  end

  if ~problem.useSparseObs & ~isfield(problem,'observation')
    for a=1:problem.nrActions
      problem.observation{a}=zeros(size(problem.observationS{a}));
      problem.observation{a}=full(problem.observationS{a});
      problem.observationCum{a}=cumsum(problem.observation{a},2);
    end
  end
  
  if problem.useReward3 & ~problem.useSparseReward & ...
        ~isfield(problem,'reward3')
    problem.reward3=zeros(problem.nrStates,problem.nrStates, ...
                          problem.nrActions);
    for a=1:problem.nrActions
      problem.reward3(:,:,a)=full(problem.reward3S{a});
    end
  end

  if ~problem.useSparseReward & ~isfield(problem,'reward')
    problem.reward=zeros(problem.nrStates,problem.nrActions);
    for a=1:problem.nrActions
      problem.reward(:,a)=full(problem.rewardS{a});
    end
  end

  if problem.useSparseReward
    uniqueR=full(unique(problem.rewardS{1}))';
    for a=2:problem.nrActions
      uniqueR=unique([uniqueR full(unique(problem.rewardS{a})')]);
    end
    problem.nrRewards=length(uniqueR);
    problem.rewards=uniqueR;
  elseif ~isfield(problem,'rewards')
    problem.rewards=unique(problem.reward);
    problem.nrRewards=length(unique(problem.reward));
  end    
else
  problem.beliefs=zeros(64,problem.nrStates);

  problem.rewards=unique(problem.reward);
  problem.nrRewards=length(unique(problem.reward));
  
  problem.transitionCum=cumsum(problem.transition);
  problem.observationCum=cumsum(problem.observation,3);
end
problem.nrBeliefs=0;

clear problem.steps;
problem.stepsSize=64;
problem.steps=repmat(uint16(0),problem.stepsSize,1);
problem.nrSteps=0;

resetState;
resetBelief;
