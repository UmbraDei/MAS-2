function [R,trace] = sampleRewards(solution,nrStarts,maxNrSteps,nrRuns)
% sampleRewards - test the control quality of a POMDP solution
%
% R = sampleRewards(solution,nrStarts,maxNrSteps,nrRuns)
%
% solution   - value function, any format accepted by getAction.m
% nrStarts   - number of different start states
% maxNrSteps - the maximum number of steps allowed from each start state
% nrRuns     - the number of runs from each start state
% 
% Returns
% R - ((nrStarts*nrRuns) x 4) sampled rewards:
%                             R(:,1) sum of rewards
%                             R(:,2) bool, whether the episode was ended
%                             R(:,3) number of steps it took
%                             R(:,4) discounted sum of rewards

% Author: Matthijs Spaan
% $Id: sampleRewards.m,v 1.16 2004/09/20 13:06:36 mtjspaan Exp $
% Copyright (c) 2003,2004 Universiteit van Amsterdam.  All rights reserved.
% More information is in the file named COPYING.

if nargin<4, nrRuns=[]; end
if nargin<3, maxNrSteps=[]; end
if nargin<2, nrStarts=[]; end
if nargin<1, solution=[]; end

clear global problem;
global problem;

initProblem;

if isempty(nrStarts) & isempty(maxNrSteps) & isempty(nrStarts)
  [nrStarts,maxNrSteps,nrRuns] = getDefaultSamplingParams;
end

totalNrRuns=nrStarts*nrRuns;
problem.maxNrSteps=maxNrSteps;

inlineGetAction=0;
if isstruct(solution)
  inlineGetAction=1;
  Vv=vertcat(solution.v);
  Va=vertcat(solution.a);
  [nrInV,d]=size(Vv);
  Vv=Vv';
end

inlineGetReward=1;

if isfield(problem,'reward3')
  useReward3=1;
else
  useReward3=0;
end

resetBelief;
b0=problem.belief;

R=zeros(totalNrRuns,4);

% get the start states
rand('state',42);
start=zeros(nrStarts,1);
for i=1:nrStarts
  resetState;
  start(i)=problem.state;
end

run=1;
s0=start(run);

running=1;
while running
  problem.nrSteps=problem.nrSteps+1;
  
  if inlineGetAction
    VdotB=zeros(1,nrInV);
    VdotB=b0*Vv;
    [foo,IMax]=max(VdotB,[],2);
    a=Va(IMax);
  else
    a=getAction(b0,solution);
  end
  [s1,b1,o]=getSuccessor(b0,s0,a);
  if inlineGetReward
    if useReward3
      r=problem.reward3(s1,s0,a);
    else
      r=problem.reward(s0,a);
    end
  else
    r=getReward(s1,s0,a);
  end

%  printEvent(s0,s1,b0,b1,a,o);
  
  b0=b1;

  R(run,1)=R(run,1)+r;
  R(run,4)=R(run,4)+r*problem.gamma^(problem.nrSteps-1);
  s0=s1;

  reset=0;
  if episodeEnded(r,s1)
    reset=1;
    R(run,2)=1;
  elseif problem.nrSteps==problem.maxNrSteps
    reset=1;
    R(run,2)=0;
  end
  
  if reset
    R(run,3)=problem.nrSteps;

    resetBelief;
    b0=problem.belief;
    
    run=run+1;
    if run<=totalNrRuns
      [x0,x1]=split(run,nrRuns);
      s0=start(x0);
    end
    problem.nrSteps=0;
  end
  
  if run>totalNrRuns
    running=0;
  end
end
