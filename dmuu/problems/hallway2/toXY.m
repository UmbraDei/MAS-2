function [x,y] = toXY(s)
% $Id: toXY.m,v 1.1 2003/08/13 09:10:59 mtjspaan Exp $

if s<=5
  x=s+1;
  y=5;
elseif s>=19 && s<=23
  x=s-17;
  y=1;
else
  switch (s)
   case 6
    x=1;
    y=4;
   case 7
    x=2;
    y=4;
   case 8
    x=4;
    y=4;
   case 9
    x=6;
    y=4;
   case 10
    x=7;
    y=4;
   case 11
    x=2;
    y=3;
   case 12
    x=4;
    y=3;
   case 13
    x=6;
    y=3;
   case 14
    x=1;
    y=2;
   case 15
    x=2;
    y=2;
   case 16
    x=4;
    y=2;
   case 17
    x=6;
    y=2;
   case 18
    x=7;
    y=2;
  end
end
