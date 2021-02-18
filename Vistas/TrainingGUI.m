classdef TrainingGUI
    
    properties
        modo                    string
        
        BackButton              matlab.ui.control.Button
        Title                   matlab.ui.control.Label
        
        ResetButton             matlab.ui.control.Button
        StartTrainingButton     matlab.ui.control.Button
        DropDown3              matlab.ui.control.DropDown
        Label13                 matlab.ui.control.Label
        Spinner3                matlab.ui.control.Spinner
        Label12                 matlab.ui.control.Label
        EditField1              matlab.ui.control.EditField
        Label11                 matlab.ui.control.Label
        Label10                 matlab.ui.control.Label
        Spinner2                matlab.ui.control.Spinner
        Label9                  matlab.ui.control.Label
        Spinner1                matlab.ui.control.Spinner
        Label8                  matlab.ui.control.Label
        CheckBox5               matlab.ui.control.CheckBox
        Label7                  matlab.ui.control.Label
        CheckBox4               matlab.ui.control.CheckBox
        Label6                  matlab.ui.control.Label
        CheckBox3               matlab.ui.control.CheckBox
        Label5                  matlab.ui.control.Label
        DropDown2               matlab.ui.control.DropDown
        Label4                  matlab.ui.control.Label
        CheckBox2               matlab.ui.control.CheckBox
        Label3                  matlab.ui.control.Label
        DropDown1               matlab.ui.control.DropDown
        Label2                  matlab.ui.control.Label
        CheckBox1               matlab.ui.control.CheckBox
        Label1                  matlab.ui.control.Label
        Label14                  matlab.ui.control.Label
        DropDown4               matlab.ui.control.DropDown
    end
    
    methods (Access = private)
        function createComponents(app, panel)
            % Create ResetButton
            app.ResetButton = uibutton(panel, 'push');
            app.ResetButton.FontSize = 18;
            app.ResetButton.Position = [735 60 140 40];
            app.ResetButton.Text = 'Reset';

            % Create StartTrainingButton
            app.StartTrainingButton = uibutton(panel, 'push');
            app.StartTrainingButton.FontSize = 18;
            app.StartTrainingButton.Position = [547 60 140 40];
            app.StartTrainingButton.Text = 'Start Training';

            % Create DropDown3
            app.DropDown3 = uidropdown(panel);
            app.DropDown3.Items = {'Infinite', '1', '2', '3', '4', '5'};
            app.DropDown3.FontSize = 16;
            app.DropDown3.Position = [786 210 89 22];
            app.DropDown3.Value = 'Infinite';

            % Create Label13
            app.Label13 = uilabel(panel);
            app.Label13.FontSize = 18;
            app.Label13.Position = [539 210 248 23];
            app.Label13.Text = 'Validation Patience:';

            % Create Spinner3
            app.Spinner3 = uispinner(panel);
            app.Spinner3.Limits = [1 10];
            app.Spinner3.ValueDisplayFormat = '%.0f';
            app.Spinner3.HorizontalAlignment = 'center';
            app.Spinner3.FontSize = 16;
            app.Spinner3.Position = [786 259 89 24];
            app.Spinner3.Value = 3;

            % Create Label12
            app.Label12 = uilabel(panel);
            app.Label12.FontSize = 18;
            app.Label12.Position = [539 260 248 23];
            app.Label12.Text = 'Validation Frequency:';

            % Create EditField1
            app.EditField1 = uieditfield(panel, 'text');
            app.EditField1.Editable = 'off';
            app.EditField1.HorizontalAlignment = 'center';
            app.EditField1.FontSize = 16;
            app.EditField1.Position = [786 309 89 24];
            app.EditField1.Value = '300';

            % Create Label11
            app.Label11 = uilabel(panel);
            app.Label11.Position = [626 302 161 22];
            app.Label11.Text = '300 / MiniBatchsize * Epochs';

            % Create Label10
            app.Label10 = uilabel(panel);
            app.Label10.FontSize = 18;
            app.Label10.Position = [539 310 248 23];
            app.Label10.Text = 'Iterations:';

            % Create Spinner2
            app.Spinner2 = uispinner(panel);
            app.Spinner2.Limits = [1 50];
            app.Spinner2.ValueDisplayFormat = '%.0f';
            app.Spinner2.HorizontalAlignment = 'center';
            app.Spinner2.FontSize = 16;
            app.Spinner2.Position = [786 359 89 24];
            app.Spinner2.Value = 10;

            % Create Label9
            app.Label9 = uilabel(panel);
            app.Label9.FontSize = 18;
            app.Label9.Position = [539 360 248 23];
            app.Label9.Text = 'Epochs:';

            % Create Spinner1
            app.Spinner1 = uispinner(panel);
            app.Spinner1.Limits = [1 100];
            app.Spinner1.ValueDisplayFormat = '%.0f';
            app.Spinner1.HorizontalAlignment = 'center';
            app.Spinner1.FontSize = 16;
            app.Spinner1.Position = [786 409 89 24];
            app.Spinner1.Value = 10;

            % Create Label8
            app.Label8 = uilabel(panel);
            app.Label8.FontSize = 18;
            app.Label8.Position = [539 410 248 23];
            app.Label8.Text = 'Mini batch size';

            % Create CheckBox5
            app.CheckBox5 = uicheckbox(panel);
            app.CheckBox5.Text = '';
            app.CheckBox5.Position = [381 110 25 22];
            app.CheckBox5.Value = true;

            % Create Label7
            app.Label7 = uilabel(panel);
            app.Label7.FontSize = 18;
            app.Label7.Position = [52 110 200 23];
            app.Label7.Text = 'Display network weights';

            % Create CheckBox4
            app.CheckBox4 = uicheckbox(panel);
            app.CheckBox4.Text = '';
            app.CheckBox4.Position = [381 160 25 22];
            app.CheckBox4.Value = true;

            % Create Label6
            app.Label6 = uilabel(panel);
            app.Label6.FontSize = 18;
            app.Label6.Position = [52 160 124 23];
            app.Label6.Text = {'Display Layers'; ''};

            % Create CheckBox3
            app.CheckBox3 = uicheckbox(panel);
            app.CheckBox3.Text = '';
            app.CheckBox3.Position = [381 210 25 22];
            app.CheckBox3.Value = true;

            % Create Label5
            app.Label5 = uilabel(panel);
            app.Label5.FontSize = 18;
            app.Label5.Position = [52 210 98 23];
            app.Label5.Text = 'Display Net';

            % Create DropDown2
            app.DropDown2 = uidropdown(panel);
            app.DropDown2.Items = {'2', '4', '6', '8', '12', '16', '20', '25'};
            app.DropDown2.FontSize = 16;
            app.DropDown2.Position = [381 260 65 22];
            app.DropDown2.Value = '6';

            % Create Label4
            app.Label4 = uilabel(panel);
            app.Label4.FontSize = 18;
            app.Label4.Position = [52 260 262 23];
            app.Label4.Text = 'Número de imagenes validadas';

            % Create CheckBox2
            app.CheckBox2 = uicheckbox(panel);
            app.CheckBox2.Text = '';
            app.CheckBox2.Position = [381 310 25 22];
            app.CheckBox2.Value = true;

            % Create Label3
            app.Label3 = uilabel(panel);
            app.Label3.FontSize = 18;
            app.Label3.Position = [52 310 198 23];
            app.Label3.Text = 'Ver imágenes validadas';

            % Create DropDown1
            app.DropDown1 = uidropdown(panel);
            app.DropDown1.Items = {'4', '6', '8', '9', '16', '20', '25', '30', '42', '56', '64'};
            app.DropDown1.FontSize = 16;
            app.DropDown1.Position = [381 360 65 22];
            app.DropDown1.Value = '64';

            % Create Label2
            app.Label2 = uilabel(panel);
            app.Label2.FontSize = 18;
            app.Label2.Position = [52 360 276 23];
            app.Label2.Text = 'Número de imagenes entrenadas';

            % Create CheckBox1
            app.CheckBox1 = uicheckbox(panel);
            app.CheckBox1.Text = '';
            app.CheckBox1.Position = [381 410 25 22];
            app.CheckBox1.Value = true;

            % Create Label1
            app.Label1 = uilabel(panel);
            app.Label1.FontSize = 18;
            app.Label1.Position = [52 410 248 23];
            app.Label1.Text = 'Ver imágenes a entrenar';
            
            % Create Label14
            app.Label14 = uilabel(panel);
            app.Label14.FontSize = 18;
            app.Label14.Position = [539 160 248 23];
            app.Label14.Text = 'Initial Learn Rate';

            % Create DropDown4
            app.DropDown4 = uidropdown(panel);
            app.DropDown4.Items = {'0.00001', '0.0001', '0.001', '0.01', '0.1'};
            app.DropDown4.FontSize = 16;
            app.DropDown4.Position = [786 160 89 22];
            app.DropDown4.Value = '0.0001';

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
            switch app.modo
                case "alexnet"
                    app.Title.Text = 'Training parameters (AlexNet)';
                case "googlenet"
                    app.Title.Text = 'Training parameters (GoogleNet)';
            end
            
            app.Spinner1.ValueChangedFcn = @app.SpinnerValueChanged;
            app.Spinner2.ValueChangedFcn = @app.SpinnerValueChanged;
            app.BackButton.ButtonPushedFcn = @app.BackButtonPushed;
            app.CheckBox1.ValueChangedFcn = @app.CheckBox1Changed;
            app.CheckBox2.ValueChangedFcn = @app.CheckBox2Changed;
            app.StartTrainingButton.ButtonPushedFcn = @app.StartTrainingButtonPushed;
            app.ResetButton.ButtonPushedFcn = @app.ResetButtonPushed;
        end
        
        function BackButtonPushed(app, button, event)
            
            switch app.modo
                case 'alexnet'
                    Controller.getInstance().execute(Events.GUI_GOTRAINING_ALEXNET, nan);
                case 'googlenet'
                    Controller.getInstance().execute(Events.GUI_GOTRAINING_GOOGLENET, nan);
            end
        end
        
        function CheckBox1Changed(app, button, event)
           
            switch app.CheckBox1.Value
                case true
                    app.DropDown1.Enable = true;
                case false
                    app.DropDown1.Enable = false;
            end
            
        end
        
        function CheckBox2Changed(app, button, event)
            
            switch app.CheckBox2.Value
                case true
                    app.DropDown2.Enable = true;
                case false
                    app.DropDown2.Enable = false;
            end
            
        end
        
        function StartTrainingButtonPushed(app, button, event)
            
            trainingImages = app.CheckBox1.Value;
            numTrainingImages = str2double(app.DropDown1.Value);
            validationImages = app.CheckBox2.Value;
            numValidationImages = str2double(app.DropDown2.Value);
            displayNet = app.CheckBox3.Value;
            displayLayers = app.CheckBox4.Value;
            displayNetworkHeights = app.CheckBox5.Value;
            miniBatchSize = app.Spinner1.Value;
            epochs = app.Spinner2.Value;
            validationFrequency = app.Spinner3.Value;
            validationPatience = inf;
            
            if app.DropDown3.Value == "Infinite"
                validationPatience = inf;
            else
                validationPatience = str2double(app.DropDown3.Value);
            end
            initialLearnRate = str2double(app.DropDown4.Value);
            
            transfer = TransferParametros(trainingImages, numTrainingImages, validationImages, numValidationImages, displayNet, displayLayers, displayNetworkHeights, miniBatchSize, epochs, validationFrequency, validationPatience, initialLearnRate);
            
            switch app.modo
                case 'alexnet'
                    Controller.getInstance().execute(Events.TRAINING_ALEXNET, transfer);
                case 'googlenet'
                    Controller.getInstance().execute(Events.TRAINING_GOOGLENET, transfer);
            end
        end
        
        function ResetButtonPushed(app, button, event)
            
            switch app.modo
                case 'alexnet'
                    Controller.getInstance().execute(Events.GUI_TRAINING_ALEXNET, nan);
                case 'googlenet'
                    Controller.getInstance().execute(Events.GUI_TRAINING_GOOGLENET, nan);
            end
        end
        
        function SpinnerValueChanged(app, button, event)
            
            minibatch = int16(app.Spinner1.Value);
            epochs = int16(app.Spinner2.Value);
            
            app.EditField1.Value = int2str(int16(300/minibatch) * epochs);            
        end
        
    end
    
    methods (Access = public)

        function app = TrainingGUI(panel,event)
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

