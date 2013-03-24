function runvi(S,params)
% runvi - run the randomized approximate POMDP algorithm
%
% runvi(S,params)
%
% S      - (n x d) belief point set to run the algorithm on
% params - struct overriding algorithm parameters, possible members:
%                 randomSeed   the seed for the random number generator,
%                              default is 42
%                 maxTime      maximum execution time for the algorithm,
%                              default is problem specific
%                 epsilon      convergence threshold, defaults to 0
%
% Results are stored in a global struct called backupStats.

% Author: Matthijs Spaan
% $Id: runvi.m,v 1.8 2004/09/23 13:32:30 mtjspaan Exp $
% Copyright (c) 2003,2004 Universiteit van Amsterdam.  All rights reserved.
% More information is in the file named COPYING.

clear global vi;
global vi;

clear global backupStats;
global backupStats;

clear global problem;
global problem;

if nargin<2, params=[]; end
if nargin<1
  error('No belief set was specified.');
end

[vi.params]=getParams(params);
[vi.n,vi.d]=size(S);
vi.S=S;

initProblem;
nrA=problem.nrActions;
nrS=problem.nrStates;
useSparse=problem.useSparse;

rand('state',vi.params.randomSeed); % seed the random number generator

vi.V=newAlpha;
vi.V.v=repmat(min(problem.rewards)/(1-problem.gamma),1, vi.d);
vi.iter=0;

[foo,foo,VdotB]=getAction(vi.S,vi.V);
vi.VB=max(VdotB,[],2);
clear VdotB;

baseFilename=sprintf('%svi%s', problem.baseFilename, ...
                     datestr(clock,30));

backupStats.randomSeed=vi.params.randomSeed;
backupStats.startTime=cputime;
backupStats.nrB=vi.n;
backupStats.params=vi.params;

running=1;
while running
  vi.iter=vi.iter+1;
  vi.nrV=length(vi.V);

  fprintf('VI[%d] |V| %d\n',vi.iter,vi.nrV);
  [vi.GammaAO,vi.GammaAOS]=computeGammaAO(vi.V);
  
  vi.Vnew=newAlpha;
  vi.newNrV=0;

  vi.VBnew=repmat(-realmax,vi.n,1);
  vi.Vmapnew=zeros(vi.n,1);
  
  pointsStillLower=1;
  while pointsStillLower
    stillLower=find(vi.VB>vi.VBnew);
    
    if vi.iter>0 & isempty(stillLower)
      fprintf('improved all points\n');
      break;
    else
      if vi.d >100
        fprintf('%d|%d|%d %d points remaining\n',vi.iter,vi.nrV, ...
                vi.newNrV,length(stillLower));
      end
      pointSelected=stillLower(ceil(rand*length(stillLower)));
    end
    
    alpha=pbSingleBackup(vi.S(pointSelected,:),vi.GammaAO,useSparse, ...
                         vi.GammaAOS);
      
    if ~tryToAddAlpha(alpha,pointSelected)
      fprintf('Hmmmmmmmmmmmmmmmmmmmmmm\n');
    end
  end
  
  if vi.iter>1
    conver=sum(vi.VBnew)/sum(vi.VB)-1;
  else
    conver=realmax;
  end
  timeSpent=cputime-backupStats.startTime;

  fprintf('convergence: current %e SumV %e timeSpent %f\n', ...
          conver,sum(vi.VBnew)/vi.n,timeSpent);

  if abs(conver)<vi.params.epsilon | timeSpent > vi.params.maxTime
    running=0;
  end
  
  vi.V=vi.Vnew;
  vi.VB=vi.VBnew;
  vi.Vmap=vi.Vmapnew;
  
  backupStats.V{vi.iter}=vi.V;
  backupStats.SumV{vi.iter}=sum(vi.VB);
  backupStats.Time{vi.iter}=cputime;
end

vi.backupStats=backupStats;
filename=sprintf('%s_%d_%d_converged_%d',baseFilename,problem.nrStates, ...
                 vi.params.randomSeed,vi.iter);
save(filename,'vi');
fprintf('Saved to %s.\n',filename);

function bool = tryToAddAlpha(alpha,i)

global vi

if alpha.v*vi.S(i,:)' < vi.VB(i)
  iOld=vi.Vmap(i);
  fprintf(['Value for %d did not increase, adding n-1 ' ...
           'vector (==%d)\n'],i,iOld);
  alpha=vi.V(iOld);
end

% check if it's new
found=0;
for j=1:vi.newNrV
  if cmp(alpha.v,vi.Vnew(j,:).v)==0
    found=1;
    break;
  end
end
if ~found
  if vi.d >100
    fprintf('%d|%d|%d Added vector for %d (V %e)\n',vi.iter, ...
            vi.nrV,vi.newNrV,i,vi.VB(i));
  end
  vi.newNrV=vi.newNrV+1;
  vi.Vnew(vi.newNrV,:)=alpha;
  alphaDotB=vi.S*alpha.v';
  I=find(alphaDotB>vi.VBnew);
  vi.Vmapnew(I)=vi.newNrV;
  vi.VBnew(I)=alphaDotB(I);
  bool=1;
else
  [foo,foo,VdotB]=getAction(vi.S(i,:),vi.Vnew);
  vi.VBnew(i)=max(VdotB);
  vi.VBnew(i)=max(vi.VBnew(i),vi.VB(i));
  bool=0;
end
