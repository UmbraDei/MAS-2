function initProblemGeneric
% initProblemGeneric - POMDP initialization code for each problem
%
% initProblemGeneric takes a global pomdp struct and copies it to a
% problem struct. It initializes some struct members common to all
% problems and makes sure the transition, observation and reward model
% are in the desired format.

% $Id: initProblemGeneric.m,v 1.23 2005/08/17 22:11:50 matthijs Exp $

global problem;

if ~isfield(problem,'unixName');
  problem.unixName=getUnixName;
end

simplifyReward;
  
pomdpToProblem;

if isfield(problem,'start');
  problem.startCum=cumsum(problem.start);
end

if problem.useSparse
  if ~isfield(problem,'useSparseObs');
    problem.useSparseObs=problem.useSparse;
  end
  if ~isfield(problem,'useSparseReward');
    problem.useSparseReward=0;
  end
  
  if ~isfield(problem,'transitionS')
    for a=1:problem.nrActions
      problem.transitionS{a}=sparse(problem.transition(:,:,a));
      problem.observationS{a}= ...
          sparse(squeeze(problem.observation(:,a,:)));
    end
  end
      
  if ~problem.useSparseObs && ~ ...
        isfield(problem,'observation')
    for a=1:problem.nrActions
      problem.observation{a}=zeros(size(problem.observationS{a}));
      problem.observation{a}=full(problem.observationS{a});
      problem.observationCum{a}=cumsum(problem.observation{a},2);
    end
  end
  
  if ~problem.useSparseReward && ~isfield(problem,'reward')
    problem.reward=zeros(problem.nrStates,problem.nrActions);
    for a=1:problem.nrActions
      problem.reward(:,a)=full(problem.rewardS{a});
    end
  end

  if ~isfield(problem,'rewards')
    if problem.useSparseReward
      uniqueR=full(unique(problem.rewardS{1}))';
      for a=2:problem.nrActions
        uniqueR=unique([uniqueR full(unique(problem.rewardS{a})')]);
      end
      problem.nrRewards=length(uniqueR);
      problem.rewards=uniqueR;
    else
      problem.rewards=unique(problem.reward);
      problem.nrRewards=length(unique(problem.reward));
    end
  end  
else
  if isfield(problem,'transitionS')
    problem=rmfield(problem,'transitionS');
  end
  if isfield(problem,'observationS')
    problem=rmfield(problem,'observationS');
  end
  if isfield(problem,'rewardS')
    problem=rmfield(problem,'rewardS');
  end
  if isfield(problem,'reward3S')
    problem=rmfield(problem,'reward3S');
  end
end

if isfield(problem,'reward3')
  problem=rmfield(problem,'reward3');
end

resetState;
resetBelief;

