function unixName = getUnixName
% $Id: getUnixName.m,v 1.2 2006/10/27 11:53:13 mtjspaan Exp $

unixName=pwd;
if ispc
  slashes=find(unixName=='\');
else
  slashes=find(unixName=='/');
end
unixName=unixName(slashes(end)+1:end);
