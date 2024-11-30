function gui = gui(varargin)
    gui = struct();
    gui.fig = figure('Name', 'GUI', 'NumberTitle', 'off', 'MenuBar', 'none', 'ToolBar', 'none', 'Resize', 'off', 'Position', [100, 100, 800, 600]);
    gui.ax = axes('Parent', gui.fig, 'Position', [0.1, 0.1, 0.8, 0.8]);
    gui.btn = uicontrol('Parent', gui.fig, 'Style', 'pushbutton', 'String', 'Click me', 'Position', [10, 10, 100, 30], 'Callback', @btn_callback);
    gui.txt = uicontrol('Parent', gui.fig, 'Style', 'text', 'String', 'Hello, world!', 'Position', [120, 10, 100, 30]);
    gui.data = 0;
    if nargin > 0
        gui.data = varargin{1};
    end
end