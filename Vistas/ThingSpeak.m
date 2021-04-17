classdef ThingSpeak < handle
    properties
        BackButton              matlab.ui.control.Button
        Title                   matlab.ui.control.Label
        AutobusesLabel          matlab.ui.control.Label
        CamionesFurgoLabel      matlab.ui.control.Label
        MotosLabel              matlab.ui.control.Label
        DelanteraCochesLabel    matlab.ui.control.Label
        TraseraCochesLabel      matlab.ui.control.Label
        BusCount                matlab.ui.control.Label
        CamionesCount           matlab.ui.control.Label
        MotosCount              matlab.ui.control.Label
        DelanteraCount          matlab.ui.control.Label
        TraseraCount            matlab.ui.control.Label
        DatePicker              matlab.ui.control.DatePicker
        FechadelvideoLabel      matlab.ui.control.Label
        HoradelvideoLabel       matlab.ui.control.Label
        SpinnerH                matlab.ui.control.Spinner
        SpinnerM                matlab.ui.control.Spinner
        SpinnerS                matlab.ui.control.Spinner
        hLabel                  matlab.ui.control.Label
        mLabel                  matlab.ui.control.Label
        sLabel                  matlab.ui.control.Label
        SendtoThingSpeakButton  matlab.ui.control.Button
        CancelButton            matlab.ui.control.Button
        Map                     matlab.ui.control.Image
        LabelLocation           matlab.ui.control.Label
        CamaraLabel             matlab.ui.control.Label
        CamaraDropDown          matlab.ui.control.DropDown
        ChannelsIdMap           containers.Map
        ChannelsReadKeyMap      containers.Map
        ChannelsWriteKeyMap     containers.Map
        ChannelsImageKeyMap     containers.Map
        transferIdentified      TransferIdentified
        mode                    string
        globe
    end
    
    methods (Access = private)
        function createComponents(app, panel)
            f = waitbar(0,'Loading...', 'WindowStyle', 'modal');
            % Create BackButton
            app.BackButton = uibutton(panel, 'push');
            app.BackButton.FontSize = 16;
            app.BackButton.Position = [770 485 150 40];
            app.BackButton.Text = 'Back';

            % Create Title
            app.Title = uilabel(panel);
            app.Title.FontSize = 40;
            app.Title.FontWeight = 'bold';
            app.Title.Position = [40 480 500 70];
            switch app.mode
                case "alexnet"
                    app.Title.Text = 'ThingSpeak (AlexNet)';
                case "googlenet"
                    app.Title.Text = 'ThingSpeak (GoogleNet)';
            end

            % Create AutobusesLabel
            app.AutobusesLabel = uilabel(panel);
            app.AutobusesLabel.HorizontalAlignment = 'right';
            app.AutobusesLabel.FontSize = 16;
            app.AutobusesLabel.Position = [40 421 125 33];
            app.AutobusesLabel.Text = 'Autobuses:';

            % Create CamionesFurgoLabel
            app.CamionesFurgoLabel = uilabel(panel);
            app.CamionesFurgoLabel.HorizontalAlignment = 'right';
            app.CamionesFurgoLabel.FontSize = 16;
            app.CamionesFurgoLabel.Position = [40 389 125 33];
            app.CamionesFurgoLabel.Text = 'CamionesFurgo:';

            % Create MotosLabel
            app.MotosLabel = uilabel(panel);
            app.MotosLabel.HorizontalAlignment = 'right';
            app.MotosLabel.FontSize = 16;
            app.MotosLabel.Position = [40 357 125 33];
            app.MotosLabel.Text = 'Motos:';

            % Create DelanteraCochesLabel
            app.DelanteraCochesLabel = uilabel(panel);
            app.DelanteraCochesLabel.HorizontalAlignment = 'right';
            app.DelanteraCochesLabel.FontSize = 16;
            app.DelanteraCochesLabel.Position = [27 325 138 33];
            app.DelanteraCochesLabel.Text = 'Delantera Coches:';

            % Create TraseraCochesLabel
            app.TraseraCochesLabel = uilabel(panel);
            app.TraseraCochesLabel.HorizontalAlignment = 'right';
            app.TraseraCochesLabel.FontSize = 16;
            app.TraseraCochesLabel.Position = [40 293 125 33];
            app.TraseraCochesLabel.Text = 'Trasera Coches:';

            % Create BusCount
            app.BusCount = uilabel(panel);
            app.BusCount.FontSize = 16;
            app.BusCount.Position = [185 421 125 33];
            app.BusCount.Text = '0';

            % Create CamionesCount
            app.CamionesCount = uilabel(panel);
            app.CamionesCount.FontSize = 16;
            app.CamionesCount.Position = [185 389 125 33];
            app.CamionesCount.Text = '0';

            % Create MotosCount
            app.MotosCount = uilabel(panel);
            app.MotosCount.FontSize = 16;
            app.MotosCount.Position = [185 357 125 33];
            app.MotosCount.Text = '0';

            % Create DelanteraCount
            app.DelanteraCount = uilabel(panel);
            app.DelanteraCount.FontSize = 16;
            app.DelanteraCount.Position = [185 325 125 33];
            app.DelanteraCount.Text = '0';

            % Create TraseraCount
            app.TraseraCount = uilabel(panel);
            app.TraseraCount.FontSize = 16;
            app.TraseraCount.Position = [185 293 125 33];
            app.TraseraCount.Text = '0';

            % Create DatePicker
            app.DatePicker = uidatepicker(panel);
            app.DatePicker.FontSize = 16;
            app.DatePicker.Position = [191 206 143 35];

            % Create FechadelvideoLabel
            app.FechadelvideoLabel = uilabel(panel);
            app.FechadelvideoLabel.HorizontalAlignment = 'right';
            app.FechadelvideoLabel.FontSize = 16;
            app.FechadelvideoLabel.Position = [46 212 125 22];
            app.FechadelvideoLabel.Text = 'Fecha del video:';

            % Create HoradelvideoLabel
            app.HoradelvideoLabel = uilabel(panel);
            app.HoradelvideoLabel.HorizontalAlignment = 'right';
            app.HoradelvideoLabel.FontSize = 16;
            app.HoradelvideoLabel.Position = [55 174 116 22];
            app.HoradelvideoLabel.Text = {'Hora del video:'; ''};

            % Create SpinnerH
            app.SpinnerH = uispinner(panel);
            app.SpinnerH.Limits = [0 23];
            app.SpinnerH.FontSize = 16;
            app.SpinnerH.Position = [191 174 62 22];

            % Create SpinnerM
            app.SpinnerM = uispinner(panel);
            app.SpinnerM.Limits = [0 59];
            app.SpinnerM.FontSize = 16;
            app.SpinnerM.Position = [191 134 62 22];

            % Create SpinnerS
            app.SpinnerS = uispinner(panel);
            app.SpinnerS.Limits = [0 59];
            app.SpinnerS.FontSize = 16;
            app.SpinnerS.Position = [191 91 62 22];

            % Create hLabel
            app.hLabel = uilabel(panel);
            app.hLabel.FontSize = 16;
            app.hLabel.Position = [260 174 25 22];
            app.hLabel.Text = 'h';

            % Create mLabel
            app.mLabel = uilabel(panel);
            app.mLabel.FontSize = 16;
            app.mLabel.Position = [262 134 25 22];
            app.mLabel.Text = {'m'; ''};

            % Create sLabel
            app.sLabel = uilabel(panel);
            app.sLabel.FontSize = 16;
            app.sLabel.Position = [260 91 25 22];
            app.sLabel.Text = 's';

            waitbar(0.16,f,'Please wait...');
            % Create SendtoThingSpeakButton
            app.SendtoThingSpeakButton = uibutton(panel, 'push');
            app.SendtoThingSpeakButton.FontSize = 16;
            app.SendtoThingSpeakButton.Position = [428 52 217 54];
            app.SendtoThingSpeakButton.Text = {'Send to ThingSpeak'; ''};
            app.SendtoThingSpeakButton.Enable = false;

            % Create CancelButton
            app.CancelButton = uibutton(panel, 'push');
            app.CancelButton.FontSize = 16;
            app.CancelButton.Position = [667 52 217 54];
            app.CancelButton.Text = 'Cancel';

            % Create LabelLocation
            app.LabelLocation = uilabel(panel);
            app.LabelLocation.FontSize = 16;
            app.LabelLocation.Position = [381 459 177 22];
            app.LabelLocation.Text = 'Ubicación de la cámara:';

            % Create CamaraLabel
            app.CamaraLabel = uilabel(panel);
            app.CamaraLabel.HorizontalAlignment = 'right';
            app.CamaraLabel.FontSize = 16;
            app.CamaraLabel.Position = [55 52 116 22];
            app.CamaraLabel.Text = 'Camara:';

            % Create CamaraDropDown
            app.CamaraDropDown = uidropdown(panel);
            app.CamaraDropDown.FontSize = 16;
            app.CamaraDropDown.Position = [185 52 197 22];
            
            waitbar(0.15,f,'Please wait...');
            % Create Map
            app.Map = uiimage(panel);
            app.Map.Position = [381 105 571 360];
            app.Map.ImageSource = 'CamaraAll.png';
            
            waitbar(0.38,f,'Please wait...');
            app.BusCount.Text = sprintf('%.0f',app.transferIdentified.BusCount);
            app.CamionesCount.Text = sprintf('%.0f',app.transferIdentified.CamionCount);
            app.MotosCount.Text = sprintf('%.0f',app.transferIdentified.MotoCount);
            app.DelanteraCount.Text = sprintf('%.0f',app.transferIdentified.DelanteraCount);
            app.TraseraCount.Text = sprintf('%.0f',app.transferIdentified.TraseraCount);
            
            waitbar(0.51,f,'Please wait...');
            app.createMaps();
            
            waitbar(0.75,f,'Please wait...');
            app.getCoordinates(app.CamaraDropDown.Value);
            
            waitbar(0.87,f,'Please wait...');
            date = datetime('now');
            app.DatePicker.Value = datetime([year(date), month(date), day(date)]);
            app.SpinnerH.Value = hour(date);
            app.SpinnerM.Value = minute(date);
            app.SpinnerS.Value = fix(second(date));
            
            waitbar(0.94,f,'Please wait...');
            app.SendtoThingSpeakButton.ButtonPushedFcn = @app.SendtoThingSpeakButtonPushed;
            app.BackButton.ButtonPushedFcn = @app.BackButtonPushed;
            app.CancelButton.ButtonPushedFcn = @app.BackButtonPushed;
            app.CamaraDropDown.ValueChangedFcn = @app.CamaraDropDownValueChanged;
            waitbar(1,f,'Please wait...');
            close(f);
        end
        
        function SendtoThingSpeakButtonPushed(app, ~, ~)
            id = app.ChannelsIdMap(app.CamaraDropDown.Value);
            date = app.DatePicker.Value;
            t = append(num2str(year(date),'%04.f'), '-', num2str(month(date),'%02.f'), '-', num2str(day(date),'%02.f'), ' ', num2str(app.SpinnerH.Value,'%02.f'), ':', num2str(app.SpinnerM.Value,'%02.f'), ':', num2str(app.SpinnerS.Value,'%02.f'));
            response = webwrite("http://api.brogame.es/thingspeak", "camera", id, "bus", app.transferIdentified.BusCount, "truck", app.transferIdentified.CamionCount, "car", app.transferIdentified.DelanteraCount + app.transferIdentified.TraseraCount, "moto", app.transferIdentified.MotoCount, "date", t);
            if(response.error)
                msgbox(response.message, 'Error', 'error');
            else
                msgbox(response.message, 'Completado', 'help');
                pause(2);
                %web(response.tweet)
            end
        end
        
        function CamaraDropDownValueChanged(app, ~, ~)
            if(strcmp(app.CamaraDropDown.Value, 'Select camera'))
                app.SendtoThingSpeakButton.Enable = false;
            else
                app.SendtoThingSpeakButton.Enable = true;
            end
            app.getCoordinates(app.CamaraDropDown.Value);
        end
        
        function BackButtonPushed(app, ~, ~)
            switch app.mode
                case 'alexnet'
                    Controller.getInstance().execute(Events.GUI_VEHICLE_DETECTION_ALEXNET, nan);
                case 'googlenet'
                    Controller.getInstance().execute(Events.GUI_VEHICLE_DETECTION_GOOGLENET, nan);
            end
        end
        
        function createMaps(app)
            keySet = {'Select camera', '1 - Moncloa', '2 - Villaverde', '3 - Usera', '4 - A2 Km52', '5 - Moratalaz', '6 - Guadalajara', '7 - Atocha', '8 - M45'};
            app.CamaraDropDown.Items = keySet;
            valueSet = {'', '1', '2', '3', '4', '5', '6', '7', '8'};
            app.ChannelsIdMap = containers.Map(keySet,valueSet);
            valueSet = {'CamaraAll.png', 'Camara1.png', 'Camara2.png', 'Camara3.png', 'Camara4.png', 'Camara5.png','Camara6.png', 'Camara7.png','Camara8.png',};
            app.ChannelsImageKeyMap = containers.Map(keySet,valueSet);
        end
        
        function getCoordinates(app, camera)
            image = app.ChannelsImageKeyMap(camera);
            app.Map.ImageSource = image;
        end
            
    end
    
    methods
        function app = ThingSpeak(panel, event, transferIdentified)
            app.transferIdentified = transferIdentified;
            
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

