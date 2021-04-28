classdef InicioGUI
    
    properties
        Titulo          matlab.ui.control.Label
        AlexNetImage    matlab.ui.control.Image
        AlexNetTitle    matlab.ui.control.Label
        AlexNetButton   matlab.ui.control.Button
        GoogleImage     matlab.ui.control.Image
        GoogleTitle     matlab.ui.control.Label
        GoogleButton    matlab.ui.control.Button
    end
    
    methods (Access = private)
        function createComponents(app, panel)
            app.Titulo = uilabel(panel);
            app.Titulo.FontSize = 40;
            app.Titulo.FontWeight = 'bold';
            app.Titulo.Position = [40 480 500 70];
            app.Titulo.Text = 'Smart Cities';
            
            app.AlexNetImage = uiimage(panel);
            app.AlexNetImage.Position = [90 330 80 80];
            app.AlexNetImage.ImageSource = 'images/alexnet.svg';
            
            app.AlexNetTitle = uilabel(panel);
            app.AlexNetTitle.FontSize = 30;
            app.AlexNetTitle.Position = [240 340 187 67];
            app.AlexNetTitle.Text = 'AlexNet';
            
            app.AlexNetButton = uibutton(panel, 'push');
            app.AlexNetButton.ButtonPushedFcn = @app.BotonAlexNetPushed;
            app.AlexNetButton.Position = [580 350 150 40];
            app.AlexNetButton.Text = 'Select';
            app.AlexNetButton.FontSize = 15;
            
            app.GoogleImage = uiimage(panel);
            app.GoogleImage.Position = [90 130 80 80];
            app.GoogleImage.ImageSource = 'images/google.svg';
            
            app.GoogleTitle = uilabel(panel);
            app.GoogleTitle.FontSize = 30;
            app.GoogleTitle.Position = [240 140 187 67];
            app.GoogleTitle.Text = 'GoogleNet';
            
            app.GoogleButton = uibutton(panel, 'push');
            app.GoogleButton.ButtonPushedFcn = @app.BotonGooglePushed;
            app.GoogleButton.Position = [580 150 150 40];
            app.GoogleButton.Text = 'Select';
            app.GoogleButton.FontSize = 15;
        end
        
        function BotonAlexNetPushed(app, button, event)
            Controller.getInstance().execute(Events.GUI_PRINCIPAL_ALEXNET, nan);
        end
        
        function BotonGooglePushed(app, button, event)
            Controller.getInstance().execute(Events.GUI_PRINCIPAL_GOOGLENET, nan);
        end
    end
    
    methods (Access = public)

        function app = InicioGUI(panel)
            app.createComponents(panel);
        end
    end
end

