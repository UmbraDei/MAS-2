function plotSingleBelief(P,plotStates,doMap)
% $Id: plotSingleBelief.m,v 1.7 2004/01/16 10:21:55 mtjspaan Exp $

if nargin<3
  doMap=[];
end

if nargin<2
  plotStates=[];
end

doBarGraph=0;

if isempty(plotStates)
  plotStates=0;
end

if isempty(doMap)
  doMap=1;
end

global problem;

if doBarGraph
  subplot(1,2,1);
end

if plotStates
  plot(problem.MS(:,1),problem.MS(:,2),'s');
  hold on;
end

I=find(P);

clf
if doMap
  map;
else
  axis([0 180 30 200]);
  axis equal
end
hold on;

for i=1:length(I)
  [x,y]=toXY(I(i));
  if doMap
    xy=transformStates([x,y]);
  else
    xy(1)=x;
    xy(2)=y;
  end
  
  color=(1-P(I(i)))*[1 1 1];
  
  h=plot(xy(1),xy(2),'ok','MarkerSize',7,'MarkerFaceColor',color, ...
         'MarkerEdgeColor',[0 0 0]);
end

if ~doMap
  axis([0 180 30 200]);
end
hold off

if doBarGraph
  subplot(1,2,2);

  maxY=fix((max(max(P))/0.1)+1)*0.1;
  [foo,d]=size(P);

  bar(P);
  set(gca,'YLim',[0 maxY]);
  set(gca,'XLim',[0 d+1]);
end
