function S = setRandState(s)
% $Id: setRandState.m,v 1.1 2005/02/15 13:09:48 mtjspaan Exp $

if nargin<1
  s=sum(100*clock);
end

if iscell(s)
  sn=s{2};
  s=s{1};
else
  sn=s;
end

rand('state',s);
randn('state',sn);

S=getRandState;
