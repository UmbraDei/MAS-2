function plotMMDPstate(state)

global problem;

[nrX,nrY]=size(problem.map);

states=zeros(1,2);
[states(1),states(2)]=ind2sub([sqrt(problem.nrStates), sqrt(problem.nrStates)], state);

for k=[1 2]
  [x,y]=toXY(states(k));

  belief=zeros(nrX,nrY);
  belief(x,y)=1;
%  belief(find(problem.map==0))=0.2;
  subplot(1,2,k);

%  bar3(belief,1,'detached','b');
%  [maxX maxY]=size(belief);
%  set(gca,'XLim',[0 maxY+1]);
%  set(gca,'YLim',[0 maxX+1]);
%  set(gca,'ZLim',[0 1]);

%  title(sprintf('Position agent %d',k));
  imagesc(belief);
  axis equal;

end
