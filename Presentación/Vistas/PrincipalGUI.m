classdef PrincipalGUI
    
    properties
        Titulo              matlab.ui.control.Label
        modo                string
        TrainingImage       matlab.ui.control.Image
        TrainingTitle       matlab.ui.control.Label
        TrainingButton      matlab.ui.control.Button
        DetectionImage      matlab.ui.control.Image
        DetectionTitle      matlab.ui.control.Label
        DetectionButton     matlab.ui.control.Button
        BackButton          matlab.ui.control.Button
    end
    
    methods (Access = private)
        function createComponents(app, panel)
            app.Titulo = uilabel(panel);
            app.Titulo.FontSize = 40;
            app.Titulo.FontWeight = 'bold';
            app.Titulo.Position = [40 480 500 70];
            switch app.modo
                case "alexnet"
                    app.Titulo.Text = 'Alex Net';
                case "googlenet"
                    app.Titulo.Text = 'Google Net';
            end
            
            app.TrainingImage = uiimage(panel);
            app.TrainingImage.Position = [90 330 80 80];
            app.TrainingImage.ImageSource = 'images/training.svg';
            
            app.TrainingTitle = uilabel(panel);
            app.TrainingTitle.FontSize = 30;
            app.TrainingTitle.Position = [240 340 400 67];
            app.TrainingTitle.Text = 'Training';
            
            app.TrainingButton = uibutton(panel, 'push');
            app.TrainingButton.ButtonPushedFcn = @app.TrainingButtonPushed;
            app.TrainingButton.Position = [650 350 150 40];
            app.TrainingButton.Text = 'Select';
            app.TrainingButton.FontSize = 15;
            
            app.DetectionImage = uiimage(panel);
            app.DetectionImage.Position = [90 130 80 80];
            app.DetectionImage.ImageSource = 'images/radar.svg';
            
            app.DetectionTitle = uilabel(panel);
            app.DetectionTitle.FontSize = 30;
            app.DetectionTitle.Position = [240 140 400 67];
            app.DetectionTitle.Text = 'Vehicle Detection';
            
            app.DetectionButton = uibutton(panel, 'push');
            app.DetectionButton.ButtonPushedFcn = @app.DetectionButtonPushed;
            app.DetectionButton.Position = [650 150 150 40];
            app.DetectionButton.Text = 'Select';
            app.DetectionButton.FontSize = 15;
            
            app.BackButton = uibutton(panel, 'push');
            app.BackButton.ButtonPushedFcn = @app.BackButtonPushed;
            app.BackButton.Position = [770 485 150 40];
            app.BackButton.Text = 'Back';
            app.BackButton.FontSize = 16;
        end
        
        function TrainingButtonPushed(app, ~, ~)
            switch app.modo
                case "alexnet"
                    Controller.getInstance().execute(Events.GUI_GOTRAINING_ALEXNET, nan);
                case "googlenet"
                    Controller.getInstance().execute(Events.GUI_GOTRAINING_GOOGLENET, nan);
            end
        end
        
        function DetectionButtonPushed(app, ~, ~)
            switch app.modo
                case "alexnet"
                    Controller.getInstance().execute(Events.GUI_VEHICLE_DETECTION_ALEXNET, nan);
                case "googlenet"
                    Controller.getInstance().execute(Events.GUI_VEHICLE_DETECTION_GOOGLENET, nan);
            end
        end
        
        function BackButtonPushed(~, ~, ~)
            Controller.getInstance().execute(Events.GUI_INICIO, nan);
        end
    end
    
    methods (Access = public)

        function app = PrincipalGUI(panel, event)
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

