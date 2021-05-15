classdef DetectionGUI < handle
    properties
        BackButton            matlab.ui.control.Button
        Title                 matlab.ui.control.Label
        UploadVideoButton     matlab.ui.control.Button
        ButtonPlay            matlab.ui.control.Button
        ButtonStop            matlab.ui.control.Button
        ImageRecorte          matlab.ui.control.Image
        AutobusesLabel        matlab.ui.control.Label
        CamionesFurgoLabel    matlab.ui.control.Label
        MotosLabel            matlab.ui.control.Label
        DelanteraCochesLabel  matlab.ui.control.Label
        TraseraCochesLabel    matlab.ui.control.Label
        BusCount              matlab.ui.control.Label
        CamionesCount         matlab.ui.control.Label
        MotosCount            matlab.ui.control.Label
        DelanteraCount        matlab.ui.control.Label
        TraseraCount          matlab.ui.control.Label
        ProgressTotal         matlab.ui.container.Panel
        Progress              matlab.ui.container.Panel
        ProgressLabel         matlab.ui.control.Label
        ContainerVideo        matlab.ui.control.UIAxes
        mode                  string
        isPlaying             logical
        stop                  logical
        transferIdentified    TransferIdentified
    end
    
    methods (Access = private)

        function createComponents(app, panel)
            
            % Create BackButton
            app.BackButton = uibutton(panel, 'push');
            app.BackButton.FontSize = 16;
            app.BackButton.Position = [770 485 150 40];
            app.BackButton.Text = 'Volver';

            % Create Title
            app.Title = uilabel(panel);
            app.Title.FontSize = 40;
            app.Title.FontWeight = 'bold';
            app.Title.Position = [40 480 700 70];
            switch app.mode
                case "alexnet"
                    app.Title.Text = 'Detección de vehículos (AlexNet)';
                case "googlenet"
                    app.Title.Text = 'Detección de vehículos (GoogleNet)';
            end

            % Create UploadVideoButton
            app.UploadVideoButton = uibutton(panel, 'push');
            app.UploadVideoButton.FontSize = 16;
            app.UploadVideoButton.Position = [646 324 258 40];
            app.UploadVideoButton.Text = 'Cargar vídeo';

            % Create ButtonPlay
            app.ButtonPlay = uibutton(panel, 'push');
            app.ButtonPlay.Icon = 'images/play.svg';
            app.ButtonPlay.Enable = 'off';
            app.ButtonPlay.Position = [710 380 40 40];
            app.ButtonPlay.Text = '';

            % Create ButtonStop
            app.ButtonStop = uibutton(panel, 'push');
            app.ButtonStop.Icon = 'images/stop.svg';
            app.ButtonStop.Enable = 'off';
            app.ButtonStop.Position = [800 380 40 40];
            app.ButtonStop.Text = '';

            % Create ImageRecorte
            app.ImageRecorte = uiimage(panel);
            app.ImageRecorte.Position = [725 178 100 100];

            % Create AutobusesLabel
            app.AutobusesLabel = uilabel(panel);
            app.AutobusesLabel.HorizontalAlignment = 'right';
            app.AutobusesLabel.FontSize = 15;
            app.AutobusesLabel.Position = [646 131 125 33];
            app.AutobusesLabel.Text = 'Autobuses:';

            % Create CamionesFurgoLabel
            app.CamionesFurgoLabel = uilabel(panel);
            app.CamionesFurgoLabel.HorizontalAlignment = 'right';
            app.CamionesFurgoLabel.FontSize = 15;
            app.CamionesFurgoLabel.Position = [646 99 125 33];
            app.CamionesFurgoLabel.Text = 'CamionesFurgo:';

            % Create MotosLabel
            app.MotosLabel = uilabel(panel);
            app.MotosLabel.HorizontalAlignment = 'right';
            app.MotosLabel.FontSize = 15;
            app.MotosLabel.Position = [646 67 125 33];
            app.MotosLabel.Text = 'Motos:';

            % Create DelanteraCochesLabel
            app.DelanteraCochesLabel = uilabel(panel);
            app.DelanteraCochesLabel.HorizontalAlignment = 'right';
            app.DelanteraCochesLabel.FontSize = 15;
            app.DelanteraCochesLabel.Position = [641 35 130 33];
            app.DelanteraCochesLabel.Text = 'Delantera Coches:';

            % Create TraseraCochesLabel
            app.TraseraCochesLabel = uilabel(panel);
            app.TraseraCochesLabel.HorizontalAlignment = 'right';
            app.TraseraCochesLabel.FontSize = 15;
            app.TraseraCochesLabel.Position = [646 3 125 33];
            app.TraseraCochesLabel.Text = 'Trasera Coches:';

            % Create BusCount
            app.BusCount = uilabel(panel);
            app.BusCount.FontSize = 15;
            app.BusCount.Position = [783 131 125 33];
            app.BusCount.Text = '0';

            % Create CamionesCount
            app.CamionesCount = uilabel(panel);
            app.CamionesCount.FontSize = 15;
            app.CamionesCount.Position = [783 99 125 33];
            app.CamionesCount.Text = '0';

            % Create MotosCount
            app.MotosCount = uilabel(panel);
            app.MotosCount.FontSize = 15;
            app.MotosCount.Position = [783 67 125 33];
            app.MotosCount.Text = '0';

            % Create DelanteraCount
            app.DelanteraCount = uilabel(panel);
            app.DelanteraCount.FontSize = 15;
            app.DelanteraCount.Position = [783 35 125 33];
            app.DelanteraCount.Text = '0';

            % Create TraseraCount
            app.TraseraCount = uilabel(panel);
            app.TraseraCount.FontSize = 15;
            app.TraseraCount.Position = [783 3 125 33];
            app.TraseraCount.Text = '0';

            % Create ProgressTotal
            app.ProgressTotal = uipanel(panel);
            app.ProgressTotal.BackgroundColor = [1 1 1];
            app.ProgressTotal.Position = [632 431 286 10];

            % Create Progress
            app.Progress = uipanel(app.ProgressTotal);
            app.Progress.BackgroundColor = [0.0745 0.6235 1];
            app.Progress.Position = [0 0 0 10];

            % Create ProgressLabel
            app.ProgressLabel = uilabel(panel);
            app.ProgressLabel.HorizontalAlignment = 'center';
            app.ProgressLabel.Position = [632 440 286 22];
            app.ProgressLabel.Text = 'Progreso del vídeo';

            % Create ContainerVideo
            app.ContainerVideo = uiaxes(panel);
            app.ContainerVideo.Layer = 'top';
            app.ContainerVideo.XTick = [];
            app.ContainerVideo.YTick = [];
            app.ContainerVideo.GridColor = [0.8 0.8 0.8];
            app.ContainerVideo.MinorGridColor = [0.902 0.902 0.902];
            app.ContainerVideo.Position = [18 34 581 437];
            
            app.isPlaying = 0;
            app.stop = 0;
            
            app.BackButton.ButtonPushedFcn = @app.BackButtonPushed;
            app.UploadVideoButton.ButtonPushedFcn = @app.UploadVideoButtonPushed;
            disableDefaultInteractivity(app.ContainerVideo);
            app.ButtonPlay.ButtonPushedFcn = @app.ButtonPlayPushed;
            app.ButtonStop.ButtonPushedFcn = @app.ButtonStopPushed;
            app.transferIdentified = TransferIdentified();
        end
        
        function BackButtonPushed(app, ~, ~)
            
            switch app.mode
                case 'alexnet'
                    Controller.getInstance().execute(Events.GUI_PRINCIPAL_ALEXNET, nan);
                case 'googlenet'
                    Controller.getInstance().execute(Events.GUI_PRINCIPAL_GOOGLENET, nan);
            end
        end
        
        function ButtonPlayPushed(app, ~, ~)
            if app.isPlaying
                app.isPlaying = 0;
                app.ButtonPlay.Icon = 'images/play.svg';
            else
                app.isPlaying = 1;
                app.ButtonPlay.Icon = 'pause.svg';
            end
        end
        
        function ButtonStopPushed(app, ~, ~)
            app.stop = 1;
        end
        
        function UploadVideoButtonPushed(app, ~, ~)
            
            [file,folder] = uigetfile({'*.mp4'});
            rutaEntrada = fullfile(folder, file);
            
            if (file ~= 0)
                if (strlength(file) > 3 && strcmp(file(end-3:end), '.mp4'))
                    app.UploadVideoButton.Enable = false;
                    v = VideoReader(rutaEntrada);
                    app.ButtonPlay.Enable = true;
                    app.ButtonStop.Enable = true;
                    NFrames = v.NumFrames;
                    frame = 0;
                    
                    switch app.mode
                        case "alexnet"
                            load netTransferAlex;
                        case "googlenet"
                            load netTransferGoogle;
                    end
                    
                    sz = netTransfer.Layers(1).InputSize;
                    
                    opticFlow = opticalFlowFarneback;
                    reset(opticFlow);

                    frameRGB = read(v,1);
                    [M,N,s] = size(frameRGB);
                    frameRGBprev = frameRGB; 
                    frameGrayprev = rgb2gray(frameRGB);
                    
                    while hasFrame(v) && isempty(findobj(app.ContainerVideo)) == 0 && app.stop == 0
                        frameRGB = readFrame(v);
                        frameGray = rgb2gray(frameRGB);
                        flow = estimateFlow(opticFlow,frameGray);
                        a = imshow(frameRGB, 'parent', app.ContainerVideo);
                        hold(app.ContainerVideo, 'on');
                        %plot(flow,'DecimationFactor',[25 25],'ScaleFactor', 2, 'Parent', app.ContainerVideo);
                        hold(app.ContainerVideo, 'off');
                        
                        MagnitudFlow    = mat2gray(flow.Magnitude);
                        OrientacionFlow = flow.Orientation;
                        level = mean2(MagnitudFlow)+std2(MagnitudFlow);
                        BWMagFlow = MagnitudFlow > level;

                        [Labels,Nlabels] = bwlabel(BWMagFlow);
                        %figure(3); imagesc(Labels); impixelinfo; colorbar
                        RProp   = regionprops(Labels,'all');
                        RPropRed   = regionprops(Labels,frameRGB(:,:,1),'all');
                        RPropGreen = regionprops(Labels,frameRGB(:,:,2),'all');
                        RPropBlue  = regionprops(Labels,frameRGB(:,:,3),'all');
                        RPropOrientacion  = regionprops(Labels,OrientacionFlow,'all');
                        
                        AreasCandidatas = zeros(1,Nlabels);
                        j=1;
                        while j < Nlabels && isempty(findobj(app.ContainerVideo)) == 0 && app.stop == 0
                            pause(1/1000);
                          if RProp(j).Area > 500
                            AreasCandidatas(j) = 1;
                          end
                          j = j + 1;
                        end
                        amp = 0;
                        h= 1;
                        while h < Nlabels && isempty(findobj(app.ContainerVideo)) == 0 && app.stop == 0
                            pause(1/1000);
                            if AreasCandidatas(h) == 1
                              XSupIzda =  round(RProp(h).BoundingBox(1)+amp);
                              if XSupIzda <=0; XSupIzda = 1; end
                              YSupIzda =  round(RProp(h).BoundingBox(2)+amp);  
                              if YSupIzda <=0; YSupIzda = 1; end

                              XSupDcha =  round(XSupIzda + RProp(h).BoundingBox(3) + amp);
                              if XSupDcha > N; XSupDcha = N; end
                              YSupDcha =  YSupIzda; 

                              XInfIzda =  XSupIzda;
                              YInfIzda =  round(YSupIzda + RProp(h).BoundingBox(4) + amp);
                              if YInfIzda > M; YInfIzda = M; end

                              XInfDcha =  XSupDcha; 
                              YInfDcha =  YInfIzda;

                              Recorte = frameRGB(YSupIzda:1:YInfIzda,XSupIzda:1:XSupDcha,:);
                              RecorteBW = BWMagFlow(YSupIzda:1:YInfIzda,XSupIzda:1:XSupDcha,:);
                              
                              [~, ~, ~] = size(Recorte);
                              R = imresize(Recorte, [sz(1) sz(2)], 'bilinear');

                              [label, Error]  = classify(netTransfer,R);
                              [MEt,~] = max(Error);

                              Orientacion = RPropOrientacion(h).MeanIntensity;

                              if (label ~= 'Asfalto') && (label ~= 'Lineas') && (label ~= 'Muro')... 
                                 && (MEt >= 0.5)... 
                                 && RPropOrientacion(h).Centroid(2) > 500 && RPropOrientacion(h).Centroid(2) < 950
                                app.ImageRecorte.ImageSource = Recorte;
                                app.transferIdentified.addItem(XInfIzda, XInfDcha, XSupIzda, XSupDcha, YInfIzda, YInfDcha, YSupIzda, YSupDcha, label, frame);
                                switch label
                                    case 'Bus'
                                      color = 'yellow'; texto = 'Bus';
                                    case 'CamionFurgo'
                                      color = 'white'; texto = 'Camion-furgo';
                                    case 'CocheDelantera'
                                      color = 'blue'; texto = 'Car Frontal';
                                    case 'CocheTrasera'
                                      color = 'red'; texto = 'Car Trasera';
                                    case 'Moto'
                                      color = 'green'; texto = 'Moto';
                                    case 'Asfalto'
                                      color = 'black'; texto = 'Asfalto';
                                    case 'Lineas'
                                      color = 'black'; texto = 'Lineas';
                                    case 'Muro'
                                      color = 'black'; texto = 'Muro';
                                end
                                hold(app.ContainerVideo, 'on'); 
                                text(XSupDcha,YSupDcha,texto, 'Parent', app.ContainerVideo);
                                line([XSupIzda,XSupDcha],[YSupIzda,YSupDcha],'LineWidth',3,'Color',color, 'Parent', app.ContainerVideo);
                                line([XSupIzda,XInfIzda],[YSupIzda,YInfIzda],'LineWidth',3,'Color',color, 'Parent', app.ContainerVideo);
                                line([XSupDcha,XInfDcha],[YSupDcha,YInfDcha],'LineWidth',3,'Color',color, 'Parent', app.ContainerVideo);
                                line([XInfIzda,XInfDcha],[YInfIzda,YInfDcha],'LineWidth',3,'Color',color, 'Parent', app.ContainerVideo);
                                hold(app.ContainerVideo, 'off');
                              end
                            end
                            h = h +1;
                        end
                        while app.isPlaying == 0 && app.stop == 0
                            pause(1/1000);
                        end
                        app.transferIdentified.cleanArrrays(frame);
                        if isempty(findobj(app.ContainerVideo)) == 0
                            app.updateProgress(frame, NFrames);
                        end
                        frame = frame + 1;
                    end
                    app.transferIdentified.completeCount();
                    if isempty(findobj(app.ContainerVideo)) == 0
                        app.updateProgress(frame, NFrames);
                    end
                    switch app.mode
                        case 'alexnet'
                            Controller.getInstance().execute(Events.GUI_THINGSPEAK_ALEXNET, app.transferIdentified);
                        case 'googlenet'
                            Controller.getInstance().execute(Events.GUI_THINGSPEAK_GOOGLENET, app.transferIdentified);
                    end
            
                else
                    msgbox('Formato de archivo no válido', '', "error");
                end
            end
        end
        
        function updateProgress(app, frame, totalFrames)
            widthTotal = app.ProgressTotal.Position(3);
            width = (widthTotal * frame) / totalFrames;
            app.Progress.Position = [0, 0, width, 10];
            
            app.BusCount.Text = sprintf('%.0f',app.transferIdentified.BusCount);
            app.CamionesCount.Text = sprintf('%.0f',app.transferIdentified.CamionCount);
            app.MotosCount.Text = sprintf('%.0f',app.transferIdentified.MotoCount);
            app.DelanteraCount.Text = sprintf('%.0f',app.transferIdentified.DelanteraCount);
            app.TraseraCount.Text = sprintf('%.0f',app.transferIdentified.TraseraCount);
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

