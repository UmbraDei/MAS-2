function initPOMDP(filename)
% initPOMDP - load a POMDP problem specification
%
% initPOMDP(filename)
%
% filename - string, denotes the .POMDP file to load
%
% initPOMDP call readPOMDP.m to parse the POMDP file (in Tony's POMDP
% file format) and caches the result for faster loading in the future.

% Author: Matthijs Spaan
% $Id: initPOMDP.m,v 1.8 2004/07/16 11:18:00 mtjspaan Exp $
% Copyright (c) 2003,2004 Universiteit van Amsterdam.  All rights reserved.
% More information is in the file named COPYING.

global problem;
global pomdp;

if nargin<1
  filename=sprintf('%s.POMDP',problem.unixName);
end

pomdpFile=sprintf('%s/%s.mat',getDataDir,filename);
fid=fopen(pomdpFile,'r');
if fid==-1
  fprintf('initPOMDP: parsing %s',filename);
  parsePOMDP(filename,pomdpFile);
else
  % check whether POMDP file is newer than the .mat file
  mat=dir(pomdpFile);
  pomdp=dir(filename);
  if isempty(pomdp)
    fprintf('initPOMDP: no .POMDP file, loading %s.mat',filename);
    fclose(fid);
    load(pomdpFile);
  elseif datenum(pomdp.date) > datenum(mat.date)
    fprintf('initPOMDP: re-parsing %s',filename);
    parsePOMDP(filename,pomdpFile);
  else
    fprintf('initPOMDP: loading %s.mat',filename);
    fclose(fid);
    load(pomdpFile);
  end
end

fprintf('.\n');

function parsePOMDP(filename,pomdpFile)

global pomdp;
global problem;
pomdp=readPOMDP(filename,problem.useSparse);
% normalize to get rid of rounding artefacts
if problem.useSparse
  for a=1:pomdp.nrActions
    pomdp.transitionS{a}=pomdp.transitionS{a}./ ...
        repmat(sum(pomdp.transitionS{a}),pomdp.nrStates,1);
  end
else
  pomdp.transition=pomdp.transition./ ...
      repmat(sum(pomdp.transition),pomdp.nrStates,1);
end
  
save(pomdpFile,'pomdp');
