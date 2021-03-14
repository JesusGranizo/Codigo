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
        PanelLocation           matlab.ui.container.Panel
        LabelLocation           matlab.ui.control.Label
        CamaraLabel             matlab.ui.control.Label
        CamaraDropDown          matlab.ui.control.DropDown
        Map                     containers.Map
        transferIdentified      TransferIdentified
        modo                    string
        globe
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
            app.Title.Position = [40 480 500 70];
            app.Title.Text = 'Titulo';

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

            % Create SendtoThingSpeakButton
            app.SendtoThingSpeakButton = uibutton(panel, 'push');
            app.SendtoThingSpeakButton.FontSize = 16;
            app.SendtoThingSpeakButton.Position = [428 52 217 54];
            app.SendtoThingSpeakButton.Text = {'Send to ThingSpeak'; ''};

            % Create CancelButton
            app.CancelButton = uibutton(panel, 'push');
            app.CancelButton.FontSize = 16;
            app.CancelButton.Position = [667 52 217 54];
            app.CancelButton.Text = 'Cancel';

            % Create PanelLocation
            app.PanelLocation = uipanel(panel);
            app.PanelLocation.Position = [381 126 539 328];

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
            app.CamaraDropDown.Items = {'Camera 1', 'Camera 2'};
            app.CamaraDropDown.FontSize = 16;
            app.CamaraDropDown.Position = [185 52 149 22];
            
            app.globe = geoglobe(app.PanelLocation,'Basemap','streets');
            
            app.DatePicker.Value = datetime([2021 3 16]);
            keySet = app.CamaraDropDown.Items;
            valueSet = [1327228 1327227];
            app.Map = containers.Map(keySet,valueSet);
            channelID = app.Map(app.CamaraDropDown.Value);
            data = thingSpeakRead(channelID, 'Location',true, 'ReadKey','SNU7MSCAEYJ7TQND');
            campos(app.globe, data(5), data(6), 5000);
            app.SendtoThingSpeakButton.ButtonPushedFcn = @app.SendtoThingSpeakButtonPushed;
            app.CamaraDropDown.ValueChangedFcn = @app.CamaraDropDownValueChanged;
        end
        
        function SendtoThingSpeakButtonPushed(app, button, event)
            channelID = app.Map(app.CamaraDropDown.Value);
            data = thingSpeakRead(channelID, 'Location',true, 'ReadKey','SNU7MSCAEYJ7TQND');
            date = app.DatePicker.Value;
            t =datetime(year(date),month(date),day(date),app.SpinnerH.Value, app.SpinnerM.Value, app.SpinnerS.Value);
            thingSpeakWrite(channelID,[app.transferIdentified.BusCount, app.transferIdentified.CamionCount, app.transferIdentified.DelanteraCount + app.transferIdentified.TraseraCount, app.transferIdentified.MotoCount],'Location',[data(5), data(6), 500],'WriteKey','0V0QOMRCZXKI4QM4','TimeStamp',t);
        end
        
        function CamaraDropDownValueChanged(app, ~, ~)
            channelID = app.Map(app.CamaraDropDown.Value);
            data = thingSpeakRead(channelID, 'Location',true, 'ReadKey','SNU7MSCAEYJ7TQND');
            campos(app.globe, data(5), data(6), 5000);
            i = 0;
        end
    end
    
    methods
        function app = ThingSpeak(panel, event, transferIdentified)
            app.transferIdentified = transferIdentified;
            
            switch event
                case Events.MODE_ALEXNET
                    app.modo = "alexnet";
                case Events.MODE_GOOGLENET
                    app.modo = "googlenet";
            end
            app.createComponents(panel);
        end
    end
end

