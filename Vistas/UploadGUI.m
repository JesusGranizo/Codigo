classdef UploadGUI
    %UPLOADGUI Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        modo                    string
        BackButton              matlab.ui.control.Button
        Title                   matlab.ui.control.Label
        Image                   matlab.ui.control.Image
        TipoDropDownLabel       matlab.ui.control.Label
        TipoDropDown            matlab.ui.control.DropDown
        DirectionDropDownLabel  matlab.ui.control.Label
        DirectionDropDown       matlab.ui.control.DropDown
        SelectImageButton       matlab.ui.control.Button
        ResetButton             matlab.ui.control.Button
        UploadImageButton       matlab.ui.control.Button
    end
    
    methods (Access = private)
        
        function BackButtonPushed(app, button, event)
            switch app.modo
                case "alexnet"
                    Controller.getInstance().execute(Events.GUI_TRAINING_ALEXNET, nan);
                case "googlenet"
                    Controller.getInstance().execute(Events.GUI_TRAINING_GOOGLENET, nan);
            end
        end
        
        function ResetButtonPushed(app, button, event)
            switch app.modo
                case "alexnet"
                    Controller.getInstance().execute(Events.GUI_UPLOAD_ALEXNET, nan);
                case "googlenet"
                    Controller.getInstance().execute(Events.GUI_UPLOAD_GOOGLENET, nan);
            end
        end
        
        function TipoDropDownValueChanged(app, button, event)
            value = app.TipoDropDown.Value;
            if strcmp(value, 'Coche')
                app.DirectionDropDown.Enable = true;
            else
                app.DirectionDropDown.Enable = false;
            end
        end
        
        function SelectImageButtonPushed(app, button, event)
            [file,folder] = uigetfile({'*.jpg'});
            rutaEntrada = fullfile(folder, file);
            
            if (file ~= 0)
                if (strlength(file) > 3 && strcmp(file(end-3:end), '.jpg'))
                    app.Image.ImageSource = rutaEntrada;
                    app.UploadImageButton.Enable = true;
                else
                    msgbox('Formato de archivo no válido', '', "error");
                end
            end            
        end
        
        function UploadImageButtonPushed(app, button, event)
            I = imread(app.Image.ImageSource);
            value = app.TipoDropDown.Value;
            if strcmp(value, 'Coche')
                valorDireccion = app.DirectionDropDown.Value;
                value = strcat(value, valorDireccion);
            end
            if strcmp(app.modo, 'googlenet')
                ruta = strcat('VehiculosGoogleNet/', value);
                I = imresize(I, [224 224]);
            else
                ruta = strcat('VehiculosAlexNet/', value);
                I = imresize(I, [227 227]); 
            end
            i = 1;
            while isfile(strcat(ruta, '/',value(1:1), num2str(i,'%02.f'), 'r.jpg'))
                i = i + 1;
            end
            imwrite(I,strcat(ruta, '/',value(1:1), num2str(i,'%02.f'), 'r.jpg'))
            if isfile(strcat(ruta, '/',value(1:1), num2str(i,'%02.f'), 'r.jpg'))
                msgbox('Subida completada');
                switch app.modo
                    case "alexnet"
                        Controller.getInstance().execute(Events.GUI_UPLOAD_ALEXNET, nan);
                    case "googlenet"
                        Controller.getInstance().execute(Events.GUI_UPLOAD_GOOGLENET, nan);
                end
            else
                msgbox('Error en la subida', '', 'error');
            end
        end
    end
    
    methods
        function app = UploadGUI(panel, event)
            
            switch event
                case Events.MODE_ALEXNET
                    app.modo = "alexnet";
                case Events.MODE_GOOGLENET
                    app.modo = "googlenet";
            end
            
            app.BackButton = uibutton(panel, 'push');
            app.BackButton.ButtonPushedFcn = @app.BackButtonPushed;
            app.BackButton.FontSize = 15;
            app.BackButton.Position = [770 485 150 40];
            app.BackButton.Text = 'Back';

            % Create Title
            app.Title = uilabel(panel);
            app.Title.FontSize = 40;
            app.Title.FontWeight = 'bold';
            app.Title.Position = [40 480 500 70];
            switch app.modo
                case "alexnet"
                    app.Title.Text = 'Upload Image (AlexNet)';
                case "googlenet"
                    app.Title.Text = 'Upload Image (GoogleNet)';
            end

            % Create Image
            app.Image = uiimage(panel);
            app.Image.Position = [132 211 220 220];

            % Create TipoDropDownLabel
            app.TipoDropDownLabel = uilabel(panel);
            app.TipoDropDownLabel.HorizontalAlignment = 'right';
            app.TipoDropDownLabel.FontSize = 15;
            app.TipoDropDownLabel.Position = [585 330 49 26];
            app.TipoDropDownLabel.Text = 'Tipe:';
            
            % Create DirectionDropDown
            app.DirectionDropDown = uidropdown(panel);
            app.DirectionDropDown.FontSize = 15;
            app.DirectionDropDown.Position = [649 265 130 31];
            app.DirectionDropDown.Items = {'Delantera', 'Trasera'};
            app.DirectionDropDown.Enable = false;

            % Create TipoDropDown
            app.TipoDropDown = uidropdown(panel);
            app.TipoDropDown.FontSize = 15;
            app.TipoDropDown.Position = [649 328 130 31];
            app.TipoDropDown.Items = {'Asfalto', 'Bus', 'CamionFurgo', 'Coche', 'Lineas', 'Moto', 'Muro'};
            app.TipoDropDown.ValueChangedFcn = @app.TipoDropDownValueChanged;

            % Create DirectionDropDownLabel
            app.DirectionDropDownLabel = uilabel(panel);
            app.DirectionDropDownLabel.HorizontalAlignment = 'right';
            app.DirectionDropDownLabel.FontSize = 15;
            app.DirectionDropDownLabel.Position = [544 267 90 26];
            app.DirectionDropDownLabel.Text = 'Direction:';

            % Create ResetButton
            app.ResetButton = uibutton(panel, 'push');
            app.ResetButton.BackgroundColor = [0.9608 0.9608 0.9608];
            app.ResetButton.FontSize = 15;
            app.ResetButton.Position = [521 113 137 33];
            app.ResetButton.Text = 'Reset';
            app.ResetButton.ButtonPushedFcn = @app.ResetButtonPushed;

            % Create UploadImageButton
            app.UploadImageButton = uibutton(panel, 'push');
            app.UploadImageButton.BackgroundColor = [0.9608 0.9608 0.9608];
            app.UploadImageButton.FontSize = 15;
            app.UploadImageButton.Position = [672 113 137 33];
            app.UploadImageButton.Text = 'Upload Image';
            app.UploadImageButton.Enable = false;
            
            % Create SelectImageButton
            app.SelectImageButton = uibutton(panel, 'push');
            app.SelectImageButton.FontSize = 15;
            app.SelectImageButton.Position = [173 145 138 33];
            app.SelectImageButton.Text = 'Select Image';
            app.SelectImageButton.ButtonPushedFcn = @app.SelectImageButtonPushed;
            app.UploadImageButton.ButtonPushedFcn = @app.UploadImageButtonPushed;
        end
    end
end

