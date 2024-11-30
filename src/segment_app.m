classdef segment_app < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure              matlab.ui.Figure
        HasilLabel            matlab.ui.control.Label
        MaskLabel             matlab.ui.control.Label
        ResultImage           matlab.ui.control.Image
        MaskImage             matlab.ui.control.Image
        RunButton             matlab.ui.control.Button
        SmallInputLabel       matlab.ui.control.Label
        SelectFileButton      matlab.ui.control.Button
        SelectedImage         matlab.ui.control.Label
        DeteksiTepiLabel      matlab.ui.control.Label
        InputLabel            matlab.ui.control.Label
        MetodeDropDown        matlab.ui.control.DropDown
        MetodeDropDownLabel   matlab.ui.control.Label
        DeteksiTepiImage      matlab.ui.control.Image
        SegmentasiObjekLabel  matlab.ui.control.Label
        InputImage            matlab.ui.control.Image
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: SelectFileButton
        function SelectFileButtonPushed(app, event)
            relativePath = fullfile('..', 'images');
            
            if ~isfolder(relativePath)
                relativePath = pwd;
            end
            
            [file, path] = uigetfile({'*.jpg;*.png;*.bmp;*.jpeg', 'Image Files (*.jpg, *.png, *.bmp, *.jpeg)'}, ...
                                    'Select an Image', relativePath);
            
            if isequal(file, 0)
                return;
            end
            
            app.SelectedImage.Text = path;
            app.InputImage.ImageSource = fullfile(path, file);
        end

        % Button pushed function: RunButton
        function RunButtonPushed(app, event)
            method = app.MetodeDropDown.Value;
            inputImage = imread(app.InputImage.ImageSource);
            gray = rgb2gray(inputImage);
            gray = im2double(gray);

            switch method
                case 'Laplace'
                    result = edge_laplace(gray);
                case 'LoG'
                    result = edge_log(gray, 1.4);
                case 'Sobel'
                    result = edge_sobel(gray, 2);
                case 'Prewitt'
                    result = edge_prewitt(gray);
                case 'Roberts'
                    result = edge_roberts(gray, 2);
                case 'Canny'
                    result = edge(gray, 'canny');
            end

            rgb_edge = uint8(cat(3, result, result, result) * 255);
            app.DeteksiTepiImage.ImageSource = rgb_edge;

            [mask, result] = segment_object(inputImage, result);

            rgb_mask = uint8(cat(3, mask, mask, mask) * 255);
            app.MaskImage.ImageSource = rgb_mask;

            app.ResultImage.ImageSource = result;
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [1 1 1];
            app.UIFigure.Position = [100 100 584 725];
            app.UIFigure.Name = 'MATLAB App';

            % Create InputImage
            app.InputImage = uiimage(app.UIFigure);
            app.InputImage.Position = [68 438 199 160];

            % Create SegmentasiObjekLabel
            app.SegmentasiObjekLabel = uilabel(app.UIFigure);
            app.SegmentasiObjekLabel.FontSize = 28;
            app.SegmentasiObjekLabel.FontWeight = 'bold';
            app.SegmentasiObjekLabel.Position = [68 652 250 36];
            app.SegmentasiObjekLabel.Text = 'Segmentasi Objek';

            % Create DeteksiTepiImage
            app.DeteksiTepiImage = uiimage(app.UIFigure);
            app.DeteksiTepiImage.Position = [324 438 199 160];

            % Create MetodeDropDownLabel
            app.MetodeDropDownLabel = uilabel(app.UIFigure);
            app.MetodeDropDownLabel.HorizontalAlignment = 'right';
            app.MetodeDropDownLabel.Position = [73 116 45 22];
            app.MetodeDropDownLabel.Text = 'Metode';

            % Create MetodeDropDown
            app.MetodeDropDown = uidropdown(app.UIFigure);
            app.MetodeDropDown.Items = {'Laplace', 'LoG', 'Sobel', 'Prewitt', 'Roberts', 'Canny'};
            app.MetodeDropDown.Position = [133 116 100 22];
            app.MetodeDropDown.Value = 'Laplace';

            % Create InputLabel
            app.InputLabel = uilabel(app.UIFigure);
            app.InputLabel.FontSize = 16;
            app.InputLabel.FontWeight = 'bold';
            app.InputLabel.Position = [69 611 44 22];
            app.InputLabel.Text = 'Input';

            % Create DeteksiTepiLabel
            app.DeteksiTepiLabel = uilabel(app.UIFigure);
            app.DeteksiTepiLabel.FontSize = 16;
            app.DeteksiTepiLabel.FontWeight = 'bold';
            app.DeteksiTepiLabel.Position = [325 611 98 22];
            app.DeteksiTepiLabel.Text = 'Deteksi Tepi';

            % Create SelectedImage
            app.SelectedImage = uilabel(app.UIFigure);
            app.SelectedImage.FontAngle = 'italic';
            app.SelectedImage.Position = [176 156 104 22];
            app.SelectedImage.Text = 'No image selected';

            % Create SelectFileButton
            app.SelectFileButton = uibutton(app.UIFigure, 'push');
            app.SelectFileButton.ButtonPushedFcn = createCallbackFcn(app, @SelectFileButtonPushed, true);
            app.SelectFileButton.Position = [68 155 100 23];
            app.SelectFileButton.Text = 'Select File';

            % Create SmallInputLabel
            app.SmallInputLabel = uilabel(app.UIFigure);
            app.SmallInputLabel.Position = [68 184 68 22];
            app.SmallInputLabel.Text = 'Input Image';

            % Create RunButton
            app.RunButton = uibutton(app.UIFigure, 'push');
            app.RunButton.ButtonPushedFcn = createCallbackFcn(app, @RunButtonPushed, true);
            app.RunButton.FontSize = 14;
            app.RunButton.Position = [68 61 235 32];
            app.RunButton.Text = 'Run';

            % Create MaskImage
            app.MaskImage = uiimage(app.UIFigure);
            app.MaskImage.Position = [68 229 199 160];

            % Create ResultImage
            app.ResultImage = uiimage(app.UIFigure);
            app.ResultImage.Position = [324 229 199 160];

            % Create MaskLabel
            app.MaskLabel = uilabel(app.UIFigure);
            app.MaskLabel.FontSize = 16;
            app.MaskLabel.FontWeight = 'bold';
            app.MaskLabel.Position = [69 402 45 22];
            app.MaskLabel.Text = 'Mask';

            % Create HasilLabel
            app.HasilLabel = uilabel(app.UIFigure);
            app.HasilLabel.FontSize = 16;
            app.HasilLabel.FontWeight = 'bold';
            app.HasilLabel.Position = [325 402 43 22];
            app.HasilLabel.Text = 'Hasil';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = segment_app

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end