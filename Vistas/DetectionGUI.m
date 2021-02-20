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
            switch app.mode
                case 'alexnet'
                    Controller.getInstance().execute(Events.GUI_VEHICLE_DETECTION_ALEXNET, nan);
                case 'googlenet'
                    Controller.getInstance().execute(Events.GUI_VEHICLE_DETECTION_GOOGLENET, nan);
            end
        end
        
        function UploadVideoButtonPushed(app, button, event)
            
            [file,folder] = uigetfile({'*.mp4'});
            rutaEntrada = fullfile(folder, file);
            
            if (file ~= 0)
                if (strlength(file) > 3 && strcmp(file(end-3:end), '.mp4'))
                    v = VideoReader(rutaEntrada);
                    app.ButtonPlay.Enable = true;
                    app.ButtonStop.Enable = true;
                    
                    load netTransferAlex
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
                        image(frameRGB, 'parent', app.ContainerVideo);
                        app.ContainerVideo.Visible = 'off';
                        plot(flow,'DecimationFactor',[25 25],'ScaleFactor', 2, 'Parent', app.ContainerVideo);
                        
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
                        for j=1:1:Nlabels
                          if RProp(j).Area > 500
                            AreasCandidatas(j) = 1;
                          end
                        end
                        amp = 0;
                        for h=1:1:Nlabels
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

                              [aar, bbr, ssr] = size(Recorte);
                              R = imresize(Recorte, [sz(1) sz(2)], 'bilinear');

                              [label, Error]  = classify(netTransfer,R);
                              [MEt,MaxEt] = max(Error);
                              disp('Label ='); disp(label)
                              disp('Error ='); disp(Error)

                              Orientacion = RPropOrientacion(h).MeanIntensity;

                              if (label ~= 'Asfalto') && (label ~= 'Lineas') && (label ~= 'Muro')... 
                                 && (MEt >= 0.5)... 
                                 && RPropOrientacion(h).Centroid(2) > 500 && RPropOrientacion(h).Centroid(2) < 950 
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
                                figure(1); hold on; text(XSupDcha,YSupDcha,texto)
                                line([XSupIzda,XSupDcha],[YSupIzda,YSupDcha],'LineWidth',3,'Color',color)
                                line([XSupIzda,XInfIzda],[YSupIzda,YInfIzda],'LineWidth',3,'Color',color)
                                line([XSupDcha,XInfDcha],[YSupDcha,YInfDcha],'LineWidth',3,'Color',color)
                                line([XInfIzda,XInfDcha],[YInfIzda,YInfDcha],'LineWidth',3,'Color',color)
                                hold off
                              end
                            end
                        end                        
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

