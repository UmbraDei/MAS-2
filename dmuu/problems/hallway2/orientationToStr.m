function str = orientationToStr(or)
% $Id: orientationToStr.m,v 1.1 2003/08/13 09:10:59 mtjspaan Exp $

switch or
 case 1
  str='north';
 case 2
  str='east';
 case 3
  str='south';
 case 4
  str='west';
end
