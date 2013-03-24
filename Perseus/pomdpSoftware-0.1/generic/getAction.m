function [A,IMax,VdotB] = getAction(S,solution)
% getAction - extract actions for a belief set from a policy
%
% [A,IMax,VdotB] = getAction(S,solution)
%
% S        - (n x d) belief set to consider
% solution - policy, can be in different formats:
%                    solution.V , a set of alpha vectors in a struct
%                    solution.Vv and solution.Va, a vertcat'ted set of
%                                                 alpha vectors
%                    a cell array of V's, the last one is picked
%                    a plain struct array of V's
%
% Returns
% A     - (n x 1) the action for each belief in S
% IMax  - (n x 1) index of maximizing vector in solution
% VdotB - (n x solutionSize) inner product of each point with each vector
%
% This function uses direct (no lookahead) control.

% Author: Matthijs Spaan
% $Id: getAction.m,v 1.12 2004/09/09 21:34:33 mtjspaan Exp $
% Copyright (c) 2003,2004 Universiteit van Amsterdam.  All rights reserved.
% More information is in the file named COPYING.

[n,d]=size(S);
A=zeros(n,1);

if isfield(solution,'V') % alpha vectors in struct
  [A,IMax,VdotB]=getAlphaAction(S,solution.V,[]);
elseif isfield(solution,'Vv') % vertcat'ted alphavectors
  [A,IMax,VdotB]=getAlphaAction(S,solution.Vv,solution.Va);
elseif iscell(solution) % cell array of V's, pick last one
  [A,IMax,VdotB]=getAlphaAction(S,solution{length(solution)},[]);
elseif isstruct(solution) % plain alpha vectors
  [A,IMax,VdotB]=getAlphaAction(S,solution,[]);
end

function [A,IMax,VdotB] = getAlphaAction(S,V,Va)

[n,d]=size(S);
A=zeros(n,1);

[nrInV,foo]=size(V);
IMax=zeros(n,1);
VdotB=zeros(n,nrInV);

if isempty(Va)
  Vv=vertcat(V.v);
  Va=vertcat(V.a);
else
  Vv=V;
end

VdotB=S*Vv';
[foo,IMax]=max(VdotB,[],2);
A=Va(IMax);
