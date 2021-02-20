classdef DetectionGUI < handle
    properties
        BackButton         matlab.ui.control.Button
        Title              matlab.ui.control.Label
        UploadVideoButton  matlab.ui.control.Button
        ContainerImage     matlab.ui.control.Image
        InfoArea           matlab.ui.control.TextArea
        ContainerVideo     matlab.ui.control.UIAxes
        ButtonPlay         matlab.ui.control.Button
        ButtonStop         matlab.ui.control.Button       
        mode               string
        isPlaying          logical
        stop               logical
    end
    
    methods (Access = private)

        function createComponents(app, panel)
            
            % Create BackButton
            app.BackButton = uibutton(panel, 'push');
            app.BackButton.FontSize = 16;
            app.BackButton.Position = [770 485 150 40];
            app.BackButton.Text = 'Back';

            % Create Title
            app.Title = uilabel(panel);
            app.Title.FontSize = 40;
            app.Title.FontWeight = 'bold';
            app.Title.Position = [40 480 700 70];
            switch app.mode
                case "alexnet"
                    app.Title.Text = 'Vehicle Detection (AlexNet)';
                case "googlenet"
                    app.Title.Text = 'Vehicle Detection (GoogleNet)';
            end

            % Create UploadVideoButton
            app.UploadVideoButton = uibutton(panel, 'push');
            app.UploadVideoButton.FontSize = 16;
            app.UploadVideoButton.Position = [161 38 258 40];
            app.UploadVideoButton.Text = 'Upload Video';

            % Create ContainerImage
            app.ContainerImage = uiimage(panel);
            app.ContainerImage.Position = [641 296 220 138];

            % Create InfoArea
            app.InfoArea = uitextarea(panel);
            app.InfoArea.Position = [582 118 338 111];

            % Create ContainerVideo
            app.ContainerVideo = uiaxes(panel);
            app.ContainerVideo.Position = [40 134 500 320];
            app.ContainerVideo.XTick = [];
            app.ContainerVideo.YTick = [];
            
            % Create ButtonStop
            app.ButtonPlay = uibutton(panel, 'push');
            app.ButtonPlay.Icon = 'play.svg';
            app.ButtonPlay.IconAlignment = 'center';
            app.ButtonPlay.FontSize = 16;
            app.ButtonPlay.Position = [245 90 40 40];
            app.ButtonPlay.Text = '';
            app.ButtonPlay.Enable = false;
            
            % Create ButtonPlay
            app.ButtonStop = uibutton(panel, 'push');
            app.ButtonStop.Icon = 'stop.svg';
            app.ButtonStop.IconAlignment = 'center';
            app.ButtonStop.FontSize = 16;
            app.ButtonStop.Position = [295 90 40 40];
            app.ButtonStop.Text = '';
            app.ButtonStop.Enable = false;
            
            app.isPlaying = 0;
            app.stop = 0;
            
            app.BackButton.ButtonPushedFcn = @app.BackButtonPushed;
            app.UploadVideoButton.ButtonPushedFcn = @app.UploadVideoButtonPushed;
            disableDefaultInteractivity(app.ContainerVideo);
            app.ButtonPlay.ButtonPushedFcn = @app.ButtonPlayPushed;
            app.ButtonStop.ButtonPushedFcn = @app.ButtonStopPushed;
        end
        
        function BackButtonPushed(app, button, event)
            
            switch app.mode
                case 'alexnet'
                    Controller.getInstance().execute(Events.GUI_PRINCIPAL_ALEXNET, nan);
                case 'googlenet'
                    Controller.getInstance().execute(Events.GUI_PRINCIPAL_GOOGLENET, nan);
            end
        end
        
        function ButtonPlayPushed(app, button, event)
            if app.isPlaying
                app.isPlaying = 0;
                app.ButtonPlay.Icon = 'play.svg';
            else
                app.isPlaying = 1;
                app.ButtonPlay.Icon = 'pause.svg';
            end
        end
        
        function ButtonStopPushed(app, button, event)
            app.ButtonPlay.Enable = false;
            app.ButtonStop.Enable = false;
            image(null, 'parent', app.ContainerVideo);
            app.stop = 1;
        end
        
        function UploadVideoButtonPushed(app, button, event)
            
            opticFlow = opticalFlowFarneback;
            
            [file,folder] = uigetfile({'*.mp4'});
            rutaEntrada = fullfile(folder, file);
            
            if (file ~= 0)
                if (strlength(file) > 3 && strcmp(file(end-3:end), '.mp4'))
                    v = VideoReader(rutaEntrada);
                    app.ButtonPlay.Enable = true;
                    app.ButtonStop.Enable = true;
                    while hasFrame(v) && isempty(findobj(app.ContainerVideo)) == 0 && app.stop == 0
                        frameRGB = readFrame(v);
                        frameGray = rgb2gray(frameRGB);
                        flow = estimateFlow(opticFlow,frameGray);
                        image(frameRGB, 'parent', app.ContainerVideo);
                        app.ContainerVideo.Visible = 'off';
                        pause(1/v.FrameRate);
                        while app.isPlaying == 0 && app.stop == 0
                            pause(1/10);
                        end
                    end
                else
                    msgbox('Formato de archivo no válido', '', "error");
                end
            end
        end
        
    end
    
    methods
        function app = DetectionGUI(panel,event)
            switch event
                case Events.MODE_ALEXNET
                    app.mode = "alexnet";
                case Events.MODE_GOOGLENET
                    app.mode = "googlenet";
            end
            app.createComponents(panel);
        end
    end
end

