function plotSingleBelief(P)
% $Id: plotSingleBelief.m,v 1.1 2003/08/25 09:11:32 mtjspaan Exp $

[foo,d]=size(P);

belief=zeros(7*2,5*2);

for i=[1:d]
  [s,or]=splitStateOrientation(i);
  [x,y]=toXY(s);
  switch orientationToStr(or)
   case 'north'
    ox=0;
    oy=0;
   case 'east'
    ox=0;
    oy=1;
   case 'south'
    ox=1;
    oy=0;
   case 'west'
    ox=1;
    oy=1;
  end
  
  belief(x*2-ox,y*2-oy)=P(i);
end

bar3(belief,1,'detached','b');
[maxX maxY]=size(belief);
set(gca,'XLim',[0 maxY+1]);
set(gca,'YLim',[0 maxX+1]);
set(gca,'ZLim',[0 1]);
