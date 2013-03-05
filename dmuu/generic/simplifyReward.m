function simplifyReward
% simplifyReward - compute R(s,a) from R(s,a,s')

% $Id: simplifyReward.m,v 1.5 2004/07/13 14:01:00 mtjspaan Exp $

% r(s,a)=\sigma_s'\sigma_o T(s',s,a)O(s',a,o)R(s',s,a)
% PhD Cassandra, page 31

global pomdp;

if isfield(pomdp,'reward3S')
  for a=1:pomdp.nrActions
    pomdp.rewardS{a}=diag(pomdp.transitionS{a}'*pomdp.reward3S{a});
  end
elseif isfield(pomdp,'reward3')
  pomdp.reward=zeros(pomdp.nrStates,pomdp.nrActions);
  
  for a=1:pomdp.nrActions
    for s=1:pomdp.nrStates
      pomdp.reward(s,a)= ...
          pomdp.transition(:,s,a)'*pomdp.reward3(:,s,a);
    end
  end
end
