function params = getParams(userParams)
% getParams - mechanism for allowing user to set algorithm parameters
%
% params = getParams(userParams)
%
% params is a struct containing algorithm parameters, members of the
% same name in userParams override default values.

% Author: Matthijs Spaan
% $Id: getParams.m,v 1.4 2004/09/13 09:33:35 mtjspaan Exp $
% Copyright (c) 2003,2004 Universiteit van Amsterdam.  All rights reserved.
% More information is in the file named COPYING.

if nargin<1
  userParams=[];
end

params.randomSeed=42;

% algorithm variations:
params.epsilon=1e-6;%1e-3;
params.maxTime=getDefaultMaxTime;

if ~isempty(userParams)
  members=fieldnames(userParams);
  [n,foo]=size(members);
  for i=1:n
    params.(char(members([i])))=userParams.(char(members([i])));
    fprintf('getParams: set %s to %f\n',char(members([i])), ...
            params.(char(members([i]))));
  end
end
