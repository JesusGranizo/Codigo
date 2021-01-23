classdef InicioVista
    
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
        
        function BotonGoogleNetButtonPushed(app, event)
            app.AlexNetTitle.Visible = false;
        end
    end
    
    methods (Access = public)

        function app = InicioVista(panel)
            app.Titulo = uilabel(panel);
            app.Titulo.FontSize = 40;
            app.Titulo.FontWeight = 'bold';
            app.Titulo.Position = [40 480 500 54];
            app.Titulo.Text = 'Ciudades Inteligentes';
            
            app.GoogleImage = uiimage(panel);
            app.GoogleImage.Position = [90 330 80 80];
            app.GoogleImage.ImageSource = 'alexNet.svg';
            
            app.AlexNetTitle = uilabel(panel);
            app.AlexNetTitle.FontSize = 30;
            app.AlexNetTitle.Position = [240 340 187 67];
            app.AlexNetTitle.Text = 'AlexNet';
            
            app.AlexNetButton = uibutton(panel, 'push');
            %app.AlexNetButton.ButtonPushedFcn = 'AlexNetButtonPushed()';
            app.AlexNetButton.Position = [580 350 150 40];
            app.AlexNetButton.Text = 'Seleccionar';
            app.AlexNetButton.FontSize = 15;
            
            app.GoogleImage = uiimage(panel);
            app.GoogleImage.Position = [90 130 80 80];
            app.GoogleImage.ImageSource = 'google.svg';
            
            app.GoogleTitle = uilabel(panel);
            app.GoogleTitle.FontSize = 30;
            app.GoogleTitle.Position = [240 140 187 67];
            app.GoogleTitle.Text = 'GoogleNet';
            
            app.GoogleButton = uibutton(panel, 'push');
            app.GoogleButton.ButtonPushedFcn =  createCallbackFcn(app, @BotonGoogleNetButtonPushed, true);
            app.GoogleButton.Position = [580 150 150 40];
            app.GoogleButton.Text = 'Seleccionar';
            app.GoogleButton.FontSize = 15;
        end
    end
end

