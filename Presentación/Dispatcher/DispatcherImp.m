classdef DispatcherImp
    
    properties
        Ventana         matlab.ui.Figure
        Principal       matlab.ui.container.Panel
        Menu            matlab.ui.container.Panel
        TitleMenu       matlab.ui.control.Label
        MenuGUI         MenuGUI
    end
    
    methods (Access = private)

    end
    
    methods (Access = public)
        function app = DispatcherImp
            app.Ventana = uifigure('Visible', 'off');
            app.Ventana.Position = [100 100 1220 600];
            app.Ventana.Name = 'Trabajo Fin de Grado';
            app.Ventana.Resize = false;
            app.Ventana.Visible = true;
            
            app.Principal = uipanel(app.Ventana);
            app.Principal.Position = [240 20 960 560];
            
            app.Menu = uipanel(app.Ventana);
            app.Menu.BackgroundColor = [0.94 0.94 0.94];
            app.Menu.Position = [20 20 200 517];
            
            app.TitleMenu = uilabel(app.Ventana);
            app.TitleMenu.HorizontalAlignment = 'center';
            app.TitleMenu.FontSize = 26;
            app.TitleMenu.Position = [20 544 200 36];
            app.TitleMenu.Text = 'Menú';
            
            app.MenuGUI = MenuGUI(app.Menu);
        end
        
        function loadVista(app, event, data)
            
            import Vistas.*;
            import Controller.*;
            
            app.MenuGUI.select(event);
             
            delete(app.Principal.Children)
            
            switch event
                case Events.GUI_INICIO
                    InicioGUI(app.Principal);
                    
                case Events.GUI_PRINCIPAL_ALEXNET
                    PrincipalGUI(app.Principal, Events.MODE_ALEXNET);
                case Events.GUI_PRINCIPAL_GOOGLENET
                    PrincipalGUI(app.Principal, Events.MODE_GOOGLENET);
                    
                case Events.GUI_GOTRAINING_ALEXNET
                    GoTrainingGUI(app.Principal, Events.MODE_ALEXNET);
                case Events.GUI_GOTRAINING_GOOGLENET
                    GoTrainingGUI(app.Principal, Events.MODE_GOOGLENET);
                
                case Events.GUI_VEHICLE_DETECTION_ALEXNET
                    DetectionGUI(app.Principal, Events.MODE_ALEXNET);
                case Events.GUI_VEHICLE_DETECTION_GOOGLENET
                    DetectionGUI(app.Principal, Events.MODE_GOOGLENET);
                    
                case Events.GUI_UPLOAD_ALEXNET
                    UploadGUI(app.Principal, Events.MODE_ALEXNET);
                case Events.GUI_UPLOAD_GOOGLENET
                    UploadGUI(app.Principal, Events.MODE_GOOGLENET);
                
                case Events.GUI_TRAINING_ALEXNET
                    TrainingGUI(app.Principal, Events.MODE_ALEXNET);
                case Events.GUI_TRAINING_GOOGLENET
                    TrainingGUI(app.Principal, Events.MODE_GOOGLENET);
                    
                case Events.GUI_THINGSPEAK_ALEXNET
                    ThingSpeak(app.Principal, Events.MODE_ALEXNET, data);
                case Events.GUI_THINGSPEAK_GOOGLENET
                    ThingSpeak(app.Principal, Events.MODE_GOOGLENET, data);
                    
                case Events.GUI_QUERIES
                    QueriesGUI(app.Principal);
            end
        end
    end
end

