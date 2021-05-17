classdef QueriesGUI < handle
    %UPLOADGUI Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        BackButton                  matlab.ui.control.Button
        Titulo                      matlab.ui.control.Label
        CheckBoxBus                 matlab.ui.control.CheckBox
        CheckBoxTruck               matlab.ui.control.CheckBox
        CheckBoxCar                 matlab.ui.control.CheckBox
        CheckBoxMoto                matlab.ui.control.CheckBox
        TipodevehculosaelegirLabel  matlab.ui.control.Label
        SpinnerMinBus               matlab.ui.control.Spinner
        entreLabel                  matlab.ui.control.Label
        yLabel                      matlab.ui.control.Label
        SpinnerMaxBus               matlab.ui.control.Spinner
        SpinnerMinTruck             matlab.ui.control.Spinner
        entreLabel_2                matlab.ui.control.Label
        yLabel_2                    matlab.ui.control.Label
        SpinnerMaxTruck             matlab.ui.control.Spinner
        SpinnerMinCar               matlab.ui.control.Spinner
        entreLabel_3                matlab.ui.control.Label
        yLabel_3                    matlab.ui.control.Label
        SpinnerMaxCar               matlab.ui.control.Spinner
        SpinnerMinMoto              matlab.ui.control.Spinner
        entreLabel_4                matlab.ui.control.Label
        yLabel_4                    matlab.ui.control.Label
        SpinnerMaxMoto              matlab.ui.control.Spinner
        FechasaelegirLabel          matlab.ui.control.Label
        InicioLabel                 matlab.ui.control.Label
        FechaInicioDatePicker       matlab.ui.control.DatePicker
        FinalLabel                  matlab.ui.control.Label
        FechaFinalDatePicker        matlab.ui.control.DatePicker
        SpinnerInitHour             matlab.ui.control.Spinner
        SpinnerInitMin              matlab.ui.control.Spinner
        SpinnerInitSec              matlab.ui.control.Spinner
        SpinnerFinalHour            matlab.ui.control.Spinner
        SpinnerFinalMin             matlab.ui.control.Spinner
        SpinnerFinalSec             matlab.ui.control.Spinner
        CmarasLabel                 matlab.ui.control.Label
        Listcameras                 matlab.ui.control.ListBox
        SeleccionartodasButton      matlab.ui.control.Button
        BorrarseleccionadasButton   matlab.ui.control.Button
        TutorialLabel               matlab.ui.control.Label
        Label                       matlab.ui.control.Label
        Label_2                     matlab.ui.control.Label
        Label_3                     matlab.ui.control.Label
        Label_4                     matlab.ui.control.Label
        ConsultarButton             matlab.ui.control.Button
        ResetearButton              matlab.ui.control.Button
        Table                       matlab.ui.control.Table
    end
    
    methods (Access = private)
        
        function BackButtonPushed(app, ~, ~)
            switch app.modo
                case "alexnet"
                    Controller.getInstance().execute(Events.GUI_GOTRAINING_ALEXNET, nan);
                case "googlenet"
                    Controller.getInstance().execute(Events.GUI_GOTRAINING_GOOGLENET, nan);
            end
        end
        
        function ResetButtonPushed(app, ~, ~)
            switch app.modo
                case "alexnet"
                    Controller.getInstance().execute(Events.GUI_UPLOAD_ALEXNET, nan);
                case "googlenet"
                    Controller.getInstance().execute(Events.GUI_UPLOAD_GOOGLENET, nan);
            end
        end
        
        function loadCameras(app)
            url = 'http://api.brogame.es/cameras';
            data = webread(url);
            Items = [];
            for i = 1: size(data.datos)
                str = append(data.datos(i).id, ' - ', data.datos(i).name);
                Items{end+1} = str;
            end
            
            app.Listcameras.Items = Items;
        end
        
        function reset(app, ~, ~)
            app.CheckBoxBus.Value = false;
            app.CheckBoxCar.Value = false;
            app.CheckBoxMoto.Value = false;
            app.CheckBoxTruck.Value = false;
            
            app.SpinnerMinBus.Enable = false;
            app.SpinnerMaxBus.Enable = false;
            app.SpinnerMinBus.Value = 0;
            app.SpinnerMaxBus.Value = 1000;
            
            app.SpinnerMinCar.Enable = false;
            app.SpinnerMaxCar.Enable = false;
            app.SpinnerMinCar.Value = 0;
            app.SpinnerMaxCar.Value = 1000;
            
            app.SpinnerMinMoto.Enable = false;
            app.SpinnerMaxMoto.Enable = false;
            app.SpinnerMinMoto.Value = 0;
            app.SpinnerMaxMoto.Value = 1000;
            
            app.SpinnerMinTruck.Enable = false;
            app.SpinnerMaxTruck.Enable = false;
            app.SpinnerMinTruck.Value = 0;
            app.SpinnerMaxTruck.Value = 1000;
            
            date = datetime('now');
            app.FechaFinalDatePicker.Value = datetime([year(date), month(date), day(date)]);
            app.SpinnerFinalHour.Value = hour(date);
            app.SpinnerFinalMin.Value = minute(date);
            app.SpinnerFinalSec.Value = fix(second(date));
            
            app.FechaInicioDatePicker.Value = datetime([year(date) - 1, month(date), day(date)]);
            app.SpinnerInitHour.Value = hour(date);
            app.SpinnerInitMin.Value = minute(date);
            app.SpinnerInitSec.Value = fix(second(date));
            
            app.borrarCamaras();
            
            app.borrarTabla();
        end
        
        function borrarTabla(app, ~, ~)
            app.Table.ColumnSortable = true;
            app.Table.Position = [521 80 422 410];
            app.Table.Data={};
        end
        
        function borrarCamaras(app, ~, ~)
            app.Listcameras.Value = app.Listcameras.Items(1);
        end
        
        function seleccionarTodas(app, ~, ~)
            app.Listcameras.Value = app.Listcameras.Items;
        end
        
        function CheckBoxBusChanged(app, ~, ~)
           
            switch app.CheckBoxBus.Value
                case true
                    app.SpinnerMaxBus.Enable = true;
                    app.SpinnerMinBus.Enable = true;
                case false
                    app.SpinnerMaxBus.Enable = false;
                    app.SpinnerMinBus.Enable = false;
            end
        end
        
        function CheckBoxMotoChanged(app, ~, ~)
           
            switch app.CheckBoxMoto.Value
                case true
                    app.SpinnerMaxMoto.Enable = true;
                    app.SpinnerMinMoto.Enable = true;
                case false
                    app.SpinnerMaxMoto.Enable = false;
                    app.SpinnerMinMoto.Enable = false;
            end
            
        end
        
        function CheckBoxCarChanged(app, ~, ~)
           
            switch app.CheckBoxCar.Value
                case true
                    app.SpinnerMaxCar.Enable = true;
                    app.SpinnerMinCar.Enable = true;
                case false
                    app.SpinnerMaxCar.Enable = false;
                    app.SpinnerMinCar.Enable = false;
            end
            
        end
        
        function CheckBoxTruckChanged(app, ~, ~)
           
            switch app.CheckBoxTruck.Value
                case true
                    app.SpinnerMaxTruck.Enable = true;
                    app.SpinnerMinTruck.Enable = true;
                case false
                    app.SpinnerMaxTruck.Enable = false;
                    app.SpinnerMinTruck.Enable = false;
            end
            
        end
        
        function makeQuery(app, ~, ~)
            url = 'http://api.brogame.es/thingspeak?select=';
            
            if(app.CheckBoxBus.Value == true)
                url = append(url, 'bus,');
            end
            if(app.CheckBoxCar.Value == true)
                url = append(url, 'car,');
            end
            if(app.CheckBoxMoto.Value == true)
                url = append(url, 'moto,');
            end
            if(app.CheckBoxTruck.Value == true)
                url = append(url, 'truck,');
            end
            
            url = append(url, 'date,camera&where=');
            
            if(app.CheckBoxBus.Value == true)
                url = append(url, 'bus>=', string(app.SpinnerMinBus.Value));
                url = append(url, ' and bus<=', string(app.SpinnerMaxBus.Value), ' and ');
            end
            if(app.CheckBoxCar.Value == true)
                url = append(url, 'car>=', string(app.SpinnerMinCar.Value));
                url = append(url, ' and car<=', string(app.SpinnerMaxCar.Value), ' and ')
            end
            if(app.CheckBoxMoto.Value == true)
                url = append(url, 'moto>=', string(app.SpinnerMinMoto.Value));
                url = append(url, ' and moto<=', string(app.SpinnerMaxMoto.Value), ' and ')
            end
            if(app.CheckBoxTruck.Value == true)
                url = append(url, 'truck>=', string(app.SpinnerMinTruck.Value));
                url = append(url, ' and truck<=', string(app.SpinnerMaxTruck.Value), ' and ')
            end
            
            date = app.FechaInicioDatePicker.Value;
            time = append(num2str(app.SpinnerInitHour.Value,'%02.f'), ':', num2str(app.SpinnerInitMin.Value,'%02.f'), ':', num2str(app.SpinnerInitSec.Value,'%02.f'));
            url = append(url, "date>='", num2str(year(date),'%04.f'), '-', num2str(month(date),'%02.f'), '-', num2str(day(date),'%02.f'), ' ', time, "' and "); 
            
            date = app.FechaFinalDatePicker.Value;
            time = append(num2str(app.SpinnerFinalHour.Value,'%02.f'), ':', num2str(app.SpinnerFinalMin.Value,'%02.f'), ':', num2str(app.SpinnerFinalSec.Value,'%02.f'));
            url = append(url, "date<='", num2str(year(date),'%04.f'), '-', num2str(month(date),'%02.f'), '-', num2str(day(date),'%02.f'), ' ', time, "' and ("); 
            
            for i = 1: length(app.Listcameras.Value)
                str = app.Listcameras.Value(i);
                str = split(str, ' - ');
                str = string(str(1));
                url = append(url, 'camera=', str, ' or ');
            end
            
            url = char(url);
            url = url(1:end-4);
            url = append(url, ')&order=camera');
            data = webread(url);
            j = 1;
            app.Table.ColumnName = {'Cámara'};
            if(isfield(data.datos(1), 'bus'))
               app.Table.ColumnName(end+1)= {'Buses'};
               j = j +1;
            end
            if(isfield(data.datos(1), 'truck'))
               app.Table.ColumnName(end+1)= {'Camiones'};
               j = j +1;
            end
            if(isfield(data.datos(1), 'car'))
               app.Table.ColumnName(end+1)= {'Coches'};
               j = j +1;
            end
            if(isfield(data.datos(1), 'moto'))
               app.Table.ColumnName(end+1)= {'Motos'};
               j = j +1;
            end
            app.Table.ColumnName(end+1)= {'Fecha'};
            j = j +1;
            app.Table.Data = {};
            if(j < 3)
                app.Table.ColumnName = {};
                errordlg('Debes seleccionar al menos un tipo de vehículo','Error');
                return;
            end
            
            for i = 1: length(data.datos)
                col = 1;
                row = strings([1,j])
                row(col) = data.datos(i).camera;
                col = col + 1;
                if(isfield(data.datos(i), 'bus'))
                   row(col) = data.datos(i).bus;
                   col = col + 1;
                end
                if(isfield(data.datos(i), 'truck'))
                   row(col) = data.datos(i).truck;
                   col = col + 1;
                end
                if(isfield(data.datos(i), 'car'))
                   row(col) = data.datos(i).car;
                   col = col + 1;
                end
                if(isfield(data.datos(i), 'moto'))
                   row(col) = data.datos(i).moto;
                   col = col + 1;
                end
                row(col) = data.datos(i).date;
                app.Table.Data = [app.Table.Data; row];
            end
            
        end
    end
    
    methods
        function app = QueriesGUI(panel)
            
            % Create Titulo
            app.Titulo = uilabel(panel);
            app.Titulo.FontSize = 40;
            app.Titulo.FontWeight = 'bold';
            app.Titulo.Position = [40 480 500 70];
            app.Titulo.Text = 'Consultas de datos';

            % Create CheckBoxBus
            app.CheckBoxBus = uicheckbox(panel);
            app.CheckBoxBus.Text = 'Autobuses';
            app.CheckBoxBus.FontSize = 16;
            app.CheckBoxBus.Position = [40 395 203 36];

            % Create CheckBoxTruck
            app.CheckBoxTruck = uicheckbox(panel);
            app.CheckBoxTruck.Text = 'Camiones / Furgoneta';
            app.CheckBoxTruck.FontSize = 16;
            app.CheckBoxTruck.Position = [40 360 203 36];

            % Create CheckBoxCar
            app.CheckBoxCar = uicheckbox(panel);
            app.CheckBoxCar.Text = 'Coches';
            app.CheckBoxCar.FontSize = 16;
            app.CheckBoxCar.Position = [40 325 203 36];

            % Create CheckBoxMoto
            app.CheckBoxMoto = uicheckbox(panel);
            app.CheckBoxMoto.Text = 'Motocicletas';
            app.CheckBoxMoto.FontSize = 16;
            app.CheckBoxMoto.Position = [40 290 203 36];

            % Create TipodevehculosaelegirLabel
            app.TipodevehculosaelegirLabel = uilabel(panel);
            app.TipodevehculosaelegirLabel.FontSize = 22;
            app.TipodevehculosaelegirLabel.Position = [40 443 265 28];
            app.TipodevehculosaelegirLabel.Text = 'Tipo de vehículos a elegir:';

            % Create SpinnerMinBus
            app.SpinnerMinBus = uispinner(panel);
            app.SpinnerMinBus.Limits = [0 9999];
            app.SpinnerMinBus.FontSize = 16;
            app.SpinnerMinBus.Position = [292 402 77 22];

            % Create entreLabel
            app.entreLabel = uilabel(panel);
            app.entreLabel.FontSize = 16;
            app.entreLabel.Position = [244 402 42 22];
            app.entreLabel.Text = 'entre';

            % Create yLabel
            app.yLabel = uilabel(panel);
            app.yLabel.FontSize = 16;
            app.yLabel.Position = [376 402 25 22];
            app.yLabel.Text = 'y';

            % Create SpinnerMaxBus
            app.SpinnerMaxBus = uispinner(panel);
            app.SpinnerMaxBus.Limits = [0 9999];
            app.SpinnerMaxBus.FontSize = 16;
            app.SpinnerMaxBus.Position = [391 402 77 22];

            % Create SpinnerMinTruck
            app.SpinnerMinTruck = uispinner(panel);
            app.SpinnerMinTruck.Limits = [0 9999];
            app.SpinnerMinTruck.FontSize = 16;
            app.SpinnerMinTruck.Position = [292 367 77 22];
            app.SpinnerMinTruck.Value = 8000;

            % Create entreLabel_2
            app.entreLabel_2 = uilabel(panel);
            app.entreLabel_2.FontSize = 16;
            app.entreLabel_2.Position = [244 367 42 22];
            app.entreLabel_2.Text = 'entre';

            % Create yLabel_2
            app.yLabel_2 = uilabel(panel);
            app.yLabel_2.FontSize = 16;
            app.yLabel_2.Position = [376 367 25 22];
            app.yLabel_2.Text = 'y';

            % Create SpinnerMaxTruck
            app.SpinnerMaxTruck = uispinner(panel);
            app.SpinnerMaxTruck.Limits = [0 9999];
            app.SpinnerMaxTruck.FontSize = 16;
            app.SpinnerMaxTruck.Position = [391 367 77 22];
            app.SpinnerMaxTruck.Value = 8000;

            % Create SpinnerMinCar
            app.SpinnerMinCar = uispinner(panel);
            app.SpinnerMinCar.Limits = [0 9999];
            app.SpinnerMinCar.FontSize = 16;
            app.SpinnerMinCar.Position = [292 332 77 22];
            app.SpinnerMinCar.Value = 8000;

            % Create entreLabel_3
            app.entreLabel_3 = uilabel(panel);
            app.entreLabel_3.FontSize = 16;
            app.entreLabel_3.Position = [244 332 42 22];
            app.entreLabel_3.Text = 'entre';

            % Create yLabel_3
            app.yLabel_3 = uilabel(panel);
            app.yLabel_3.FontSize = 16;
            app.yLabel_3.Position = [376 332 25 22];
            app.yLabel_3.Text = 'y';

            % Create SpinnerMaxCar
            app.SpinnerMaxCar = uispinner(panel);
            app.SpinnerMaxCar.Limits = [0 9999];
            app.SpinnerMaxCar.FontSize = 16;
            app.SpinnerMaxCar.Position = [391 332 77 22];
            app.SpinnerMaxCar.Value = 8000;

            % Create SpinnerMinMoto
            app.SpinnerMinMoto = uispinner(panel);
            app.SpinnerMinMoto.Limits = [0 9999];
            app.SpinnerMinMoto.FontSize = 16;
            app.SpinnerMinMoto.Position = [292 297 77 22];
            app.SpinnerMinMoto.Value = 8000;

            % Create entreLabel_4
            app.entreLabel_4 = uilabel(panel);
            app.entreLabel_4.FontSize = 16;
            app.entreLabel_4.Position = [244 297 42 22];
            app.entreLabel_4.Text = 'entre';

            % Create yLabel_4
            app.yLabel_4 = uilabel(panel);
            app.yLabel_4.FontSize = 16;
            app.yLabel_4.Position = [376 297 25 22];
            app.yLabel_4.Text = 'y';

            % Create SpinnerMaxMoto
            app.SpinnerMaxMoto = uispinner(panel);
            app.SpinnerMaxMoto.Limits = [0 9999];
            app.SpinnerMaxMoto.FontSize = 16;
            app.SpinnerMaxMoto.Position = [391 297 77 22];
            app.SpinnerMaxMoto.Value = 8000;

            % Create FechasaelegirLabel
            app.FechasaelegirLabel = uilabel(panel);
            app.FechasaelegirLabel.FontSize = 22;
            app.FechasaelegirLabel.Position = [40 257 162 28];
            app.FechasaelegirLabel.Text = 'Fechas a elegir:';

            % Create InicioLabel
            app.InicioLabel = uilabel(panel);
            app.InicioLabel.FontSize = 16;
            app.InicioLabel.Position = [40 215 47 22];
            app.InicioLabel.Text = 'Inicio:';

            % Create FechaInicioDatePicker
            app.FechaInicioDatePicker = uidatepicker(panel);
            app.FechaInicioDatePicker.FontSize = 16;
            app.FechaInicioDatePicker.Position = [97 206 146 40];
            app.FechaInicioDatePicker.Value = datetime([2021 5 28]);

            % Create FinalLabel
            app.FinalLabel = uilabel(panel);
            app.FinalLabel.FontSize = 16;
            app.FinalLabel.Position = [40 168 45 22];
            app.FinalLabel.Text = 'Final:';

            % Create FechaFinalDatePicker
            app.FechaFinalDatePicker = uidatepicker(panel);
            app.FechaFinalDatePicker.FontSize = 16;
            app.FechaFinalDatePicker.Position = [97 159 148 40];

            % Create SpinnerInitHour
            app.SpinnerInitHour = uispinner(panel);
            app.SpinnerInitHour.Limits = [0 23];
            app.SpinnerInitHour.FontSize = 16;
            app.SpinnerInitHour.Position = [273 215 55 22];
            app.SpinnerInitHour.Value = 23;

            % Create SpinnerInitMin
            app.SpinnerInitMin = uispinner(panel);
            app.SpinnerInitMin.Limits = [0 59];
            app.SpinnerInitMin.FontSize = 16;
            app.SpinnerInitMin.Position = [347 215 55 22];
            app.SpinnerInitMin.Value = 59;

            % Create SpinnerInitSec
            app.SpinnerInitSec = uispinner(panel);
            app.SpinnerInitSec.Limits = [0 59];
            app.SpinnerInitSec.FontSize = 16;
            app.SpinnerInitSec.Position = [415 215 55 22];
            app.SpinnerInitSec.Value = 59;

            % Create SpinnerFinalHour
            app.SpinnerFinalHour = uispinner(panel);
            app.SpinnerFinalHour.Limits = [0 23];
            app.SpinnerFinalHour.FontSize = 16;
            app.SpinnerFinalHour.Position = [273 168 55 22];
            app.SpinnerFinalHour.Value = 23;

            % Create SpinnerFinalMin
            app.SpinnerFinalMin = uispinner(panel);
            app.SpinnerFinalMin.Limits = [0 59];
            app.SpinnerFinalMin.FontSize = 16;
            app.SpinnerFinalMin.Position = [347 168 55 22];
            app.SpinnerFinalMin.Value = 59;

            % Create SpinnerFinalSec
            app.SpinnerFinalSec = uispinner(panel);
            app.SpinnerFinalSec.Limits = [0 59];
            app.SpinnerFinalSec.FontSize = 16;
            app.SpinnerFinalSec.Position = [415 168 55 22];
            app.SpinnerFinalSec.Value = 59;

            % Create CmarasLabel
            app.CmarasLabel = uilabel(panel);
            app.CmarasLabel.FontSize = 22;
            app.CmarasLabel.Position = [40 124 101 28];
            app.CmarasLabel.Text = 'Cámaras:';

            % Create Listcameras
            app.Listcameras = uilistbox(panel);
            app.Listcameras.Multiselect = 'on';
            app.Listcameras.FontSize = 14;
            app.Listcameras.Position = [40 26 234 91];
            app.loadCameras();

            % Create SeleccionartodasButton
            app.SeleccionartodasButton = uibutton(panel, 'push');
            app.SeleccionartodasButton.Position = [303 80 128 22];
            app.SeleccionartodasButton.Text = 'Seleccionar todas';

            % Create BorrarseleccionadasButton
            app.BorrarseleccionadasButton = uibutton(panel, 'push');
            app.BorrarseleccionadasButton.Position = [303 46 128 22];
            app.BorrarseleccionadasButton.Text = 'Borrar seleccionadas';

            % Create MantenerteclaCtrlparaseleccinmltipleLabel
            app.TutorialLabel = uilabel(panel);
            app.TutorialLabel.Position = [40 1 234 26];
            app.TutorialLabel.Text = 'Mantener tecla Ctrl para selección múltiple';

            % Create Label
            app.Label = uilabel(panel);
            app.Label.FontSize = 20;
            app.Label.FontWeight = 'bold';
            app.Label.Position = [334 215 25 26];
            app.Label.Text = ':';

            % Create Label_2
            app.Label_2 = uilabel(panel);
            app.Label_2.FontSize = 20;
            app.Label_2.FontWeight = 'bold';
            app.Label_2.Position = [405 215 25 26];
            app.Label_2.Text = ':';

            % Create Label_3
            app.Label_3 = uilabel(panel);
            app.Label_3.FontSize = 20;
            app.Label_3.FontWeight = 'bold';
            app.Label_3.Position = [334 166 25 26];
            app.Label_3.Text = ':';

            % Create Label_4
            app.Label_4 = uilabel(panel);
            app.Label_4.FontSize = 20;
            app.Label_4.FontWeight = 'bold';
            app.Label_4.Position = [405 166 25 26];
            app.Label_4.Text = ':';

            % Create ConsultarButton
            app.ConsultarButton = uibutton(panel, 'push');
            app.ConsultarButton.FontSize = 16;
            app.ConsultarButton.Position = [539 24 176 44];
            app.ConsultarButton.Text = {'Consultar'; ''};

            % Create ResetearButton
            app.ResetearButton = uibutton(panel, 'push');
            app.ResetearButton.FontSize = 16;
            app.ResetearButton.Position = [751 24 176 44];
            app.ResetearButton.Text = 'Resetear';

            % Create Table
            app.Table = uitable(panel);
            app.Table.ColumnSortable = true;
            app.Table.Position = [521 80 422 410];
            
            app.reset();
            app.CheckBoxBus.ValueChangedFcn = @app.CheckBoxBusChanged;
            app.CheckBoxCar.ValueChangedFcn = @app.CheckBoxCarChanged;
            app.CheckBoxMoto.ValueChangedFcn = @app.CheckBoxMotoChanged;
            app.CheckBoxTruck.ValueChangedFcn = @app.CheckBoxTruckChanged;
            app.SeleccionartodasButton.ButtonPushedFcn = @app.seleccionarTodas;
            app.BorrarseleccionadasButton.ButtonPushedFcn = @app.borrarCamaras;
            app.ResetearButton.ButtonPushedFcn = @app.reset;
            app.ConsultarButton.ButtonPushedFcn = @app.makeQuery;
        end
    end
end

