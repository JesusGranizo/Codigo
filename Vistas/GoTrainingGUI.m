classdef GoTrainingGUI
    
    properties
        modo                string
        Titulo              matlab.ui.control.Label
        BackButton          matlab.ui.control.Button
        
        UploadImage         matlab.ui.control.Image
        UploadTitle         matlab.ui.control.Label
        UploadButton        matlab.ui.control.Button
        
        VisualImage         matlab.ui.control.Image
        VisualTitle         matlab.ui.control.Label
        VisualButton        matlab.ui.control.Button
        
        TrainingImage       matlab.ui.control.Image
        TrainingTitle       matlab.ui.control.Label
        TrainingButton      matlab.ui.control.Button        
    end
    
    methods (Access = private)
        function createComponents(app, panel)
            % Create Titulo
            app.Titulo = uilabel(panel);
            app.Titulo.FontSize = 40;
            app.Titulo.FontWeight = 'bold';
            app.Titulo.Position = [40 480 500 70];
            switch app.modo
                case "alexnet"
                    app.Titulo.Text = 'Training (AlexNet)';
                case "googlenet"
                    app.Titulo.Text = 'Training (GoogleNet)';
            end

            % Create UploadImage
            app.UploadImage = uiimage(panel);
            app.UploadImage.Position = [90 350 80 80];
            app.UploadImage.ImageSource = 'upload.svg';

            % Create VisualImage
            app.VisualImage = uiimage(panel);
            app.VisualImage.Position = [90 220 80 80];
            app.VisualImage.ImageSource = 'presentation.svg';

            % Create TrainingImage
            app.TrainingImage = uiimage(panel);
            app.TrainingImage.Position = [90 90 80 80];
            app.TrainingImage.ImageSource = 'training.svg';

            % Create UploadTitle
            app.UploadTitle = uilabel(panel);
            app.UploadTitle.FontSize = 30;
            app.UploadTitle.Position = [214 371 284 39];
            app.UploadTitle.Text = 'Images Upload';

            % Create VisualTitle
            app.VisualTitle = uilabel(panel);
            app.VisualTitle.FontSize = 30;
            app.VisualTitle.Position = [214 241 278 39];
            app.VisualTitle.Text = 'Images Visualization';

            % Create TrainingTitle
            app.TrainingTitle = uilabel(panel);
            app.TrainingTitle.FontSize = 30;
            app.TrainingTitle.Position = [214 111 181 39];
            app.TrainingTitle.Text = 'Start Training';

            % Create BackButton
            app.BackButton = uibutton(panel, 'push');
            app.BackButton.ButtonPushedFcn = @app.BackButtonPushed;
            app.BackButton.Position = [770 485 150 40];
            app.BackButton.Text = 'Atrás';
            app.BackButton.FontSize = 15;

            % Create UploadButton
            app.UploadButton = uibutton(panel, 'push');
            app.UploadButton.ButtonPushedFcn = @app.UploadButtonPushed;
            app.UploadButton.Position = [621 370 150 40];
            app.UploadButton.Text = {'Seleccionar'; ''};
            app.UploadButton.FontSize = 15;

            % Create VisualButton
            app.VisualButton = uibutton(panel, 'push');
            app.VisualButton.ButtonPushedFcn = @app.VisualButtonPushed;
            app.VisualButton.Position = [621 240 150 40];
            app.VisualButton.Text = {'Seleccionar'; ''};
            app.VisualButton.FontSize = 15;

            % Create TrainingButton
            app.TrainingButton = uibutton(panel, 'push');
            app.TrainingButton.ButtonPushedFcn = @app.TrainingButtonPushed;
            app.TrainingButton.Position = [621 110 150 40];
            app.TrainingButton.Text = {'Seleccionar'; ''};
            app.TrainingButton.FontSize = 15;
        end
        
        function VisualButtonPushed(app, button, event)
            
            switch app.modo
                case 'alexnet'
                    winopen('VehiculosAlexNet/');
                case 'googlenet'
                    winopen('VehiculosGoogleNet/');
            end
        end
        
        function UploadButtonPushed(app, button, event)
            switch app.modo
                case "alexnet"
                    Controller.getInstance().execute(Events.GUI_UPLOAD_ALEXNET, nan);
                case "googlenet"
                    Controller.getInstance().execute(Events.GUI_UPLOAD_GOOGLENET, nan);
            end
        end
        
        function TrainingButtonPushed(app, button, event)
            switch app.modo
                case "alexnet"
                    Controller.getInstance().execute(Events.GUI_TRAINING_ALEXNET, nan);
                case "googlenet"
                    Controller.getInstance().execute(Events.GUI_TRAINING_GOOGLENET, nan);
            end
        end
        
        function BackButtonPushed(app, button, event)
            switch app.modo
                case "alexnet"
                    Controller.getInstance().execute(Events.GUI_PRINCIPAL_ALEXNET, nan);
                case "googlenet"
                    Controller.getInstance().execute(Events.GUI_PRINCIPAL_GOOGLENET, nan);
            end
        end
    end
    
    methods (Access = public)

        function app = GoTrainingGUI(panel, event)
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

