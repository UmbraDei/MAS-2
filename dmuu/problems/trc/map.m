function map()
% This is the machine-generated representation of a Handle Graphics object
% and its children.  Note that handle values may change when these objects
% are re-created. This may cause problems with any callbacks written to
% depend on the value of the handle at the time the object was saved.
%
% To reopen this object, just type the name of the M-file at the MATLAB
% prompt. The M-file and its associated MAT-file must be on your path.

load map                               

%a = figure('Color',[0.8 0.8 0.8], ...
%           'Colormap',mat0, ...
%           'Position',[296 384 560 420]);
a = gcf;
set(a,'Color',[0.8 0.8 0.8],'Colormap',mat0);
b = axes('Parent',a, ...
	'Box','on', ...
	'CameraUpVector',[0 1 0], ...
	'Color',[1 1 1], ...
	'ColorOrder',mat1, ...
	'DataAspectRatioMode','manual', ...
	'Layer','top', ...
	'Visible','off', ...
	'WarpToFill','off', ...
	'XColor',[0 0 0], ...
	'XLim',[0.5 502.5], ...
	'XLimMode','manual', ...
	'YColor',[0 0 0], ...
	'YDir','reverse', ...
	'YLim',[0.5 475.5], ...
	'YLimMode','manual', ...
	'ZColor',[0 0 0]);
c = image('Parent',b, ...
	'CData',mat2, ...
	'CDataMapping','scaled', ...
	'XData',[1 502], ...
	'YData',[1 475]);
c = text('Parent',b, ...
	'Color',[0 0 0], ...
	'HandleVisibility','callback', ...
	'HorizontalAlignment','center', ...
	'Position',[250.804 501.966 0], ...
	'VerticalAlignment','cap', ...
	'Visible','off');
set(get(c,'Parent'),'XLabel',c);
c = text('Parent',b, ...
	'Color',[0 0 0], ...
	'HandleVisibility','callback', ...
	'HorizontalAlignment','center', ...
	'Position',[-36.1466 240.089 0], ...
	'Rotation',90, ...
	'VerticalAlignment','baseline', ...
	'Visible','off');
set(get(c,'Parent'),'YLabel',c);
c = text('Parent',b, ...
	'Color',[0 0 0], ...
	'HandleVisibility','callback', ...
	'HorizontalAlignment','right', ...
	'Position',[-151.762 -41.2889 0], ...
	'Visible','off');
set(get(c,'Parent'),'ZLabel',c);
c = text('Parent',b, ...
	'Color',[0 0 0], ...
	'HandleVisibility','callback', ...
	'HorizontalAlignment','center', ...
	'Position',[250.804 -6.46481 0], ...
	'VerticalAlignment','bottom');
set(get(c,'Parent'),'Title',c);