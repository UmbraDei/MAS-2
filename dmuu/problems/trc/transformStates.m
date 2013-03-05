function MS = transformStates(MS)
% $Id: transformStates.m,v 1.1 2003/11/17 12:04:21 mtjspaan Exp $

XLim=get(gca,'XLim');
YLim=get(gca,'YLim');

scaleX=0.65;
scaleY=0.64;
offsetX=79;
offsetY=-27;

MS(:,1)=MS(:,1).*scaleX*((XLim(2)-XLim(1))/(174-3.25));
MS(:,1)=MS(:,1)+offsetX;
MS(:,2)=MS(:,2).*scaleY*((YLim(2)-YLim(1))/(192-32.2));
MS(:,2)=YLim(2)-MS(:,2)+offsetY;
