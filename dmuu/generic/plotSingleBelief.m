function plotSingleBelief(P,s)
% $Id: plotSingleBelief.m,v 1.3 2006/06/21 09:26:28 mtjspaan Exp $

[foo,d]=size(P)

maxY=fix((max(max(P))/0.1)+1)*0.1

bar(full(P));
set(gca,'YLim',[0 maxY]);
set(gca,'XLim',[0 d+1]);
