classdef MenuGUI
    %MENUGUI Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Menu                            matlab.ui.container.Tree
        Inicio                          matlab.ui.container.TreeNode
        AlexNet                         matlab.ui.container.TreeNode
        AlexNetTraining                 matlab.ui.container.TreeNode
        AlexNetImageUpload              matlab.ui.container.TreeNode
        AlexNetImageVisualization       matlab.ui.container.TreeNode
        AlexNetModelTraining            matlab.ui.container.TreeNode
        GoogleNet                       matlab.ui.container.TreeNode
        GoogleNetTraining               matlab.ui.container.TreeNode
        GoogleNetImageUpload            matlab.ui.container.TreeNode
        GoogleNetImageVisualization     matlab.ui.container.TreeNode
        GoogleNetModelTraining          matlab.ui.container.TreeNode
    end
    
    methods (Access = private)
        function CollapseMenu(app, object, event)
            expand(app.Menu, 'all');
        end
        
        function SelectionMenu(app, object, event)
            if (app.Menu.SelectedNodes.Text == "Inicio")
                Controller.getInstance().execute(Events.GUI_INICIO, nan);
            elseif (app.Menu.SelectedNodes.Text == "AlexNet")
                Controller.getInstance().execute(Events.GUI_PRINCIPAL_ALEXNET, nan);
            elseif (app.Menu.SelectedNodes.Text == "Training" &&  app.Menu.SelectedNodes.Parent.Text == "AlexNet")
                Controller.getInstance().execute(Events.GUI_TRAINING_ALEXNET, nan);
            elseif (app.Menu.SelectedNodes.Text == "Image Upload" &&  app.Menu.SelectedNodes.Parent.Parent.Text == "AlexNet")
                Controller.getInstance().execute(Events.GUI_UPLOAD_ALEXNET, nan);
            elseif (app.Menu.SelectedNodes.Text == "Image Visualization" &&  app.Menu.SelectedNodes.Parent.Parent.Text == "AlexNet")
                Controller.getInstance().execute(Events.GUI_VISUALIZATION_ALEXNET, nan);
            elseif (app.Menu.SelectedNodes.Text == "GoogleNet")
                Controller.getInstance().execute(Events.GUI_PRINCIPAL_GOOGLENET, nan);
            elseif (app.Menu.SelectedNodes.Text == "Training" &&  app.Menu.SelectedNodes.Parent.Text == "GoogleNet")
                Controller.getInstance().execute(Events.GUI_TRAINING_GOOGLENET, nan);
            elseif (app.Menu.SelectedNodes.Text == "Image Upload" &&  app.Menu.SelectedNodes.Parent.Parent.Text == "GoogleNet")
                Controller.getInstance().execute(Events.GUI_UPLOAD_GOOGLENET, nan);
            elseif (app.Menu.SelectedNodes.Text == "Image Visualization" &&  app.Menu.SelectedNodes.Parent.Parent.Text == "AlexNet")
                Controller.getInstance().execute(Events.GUI_VISUALIZATION_GOOGLENET, nan);
            end
        end
    end
    
    methods
        function app = MenuGUI(panel)
            app.Menu = uitree(panel);
            app.Menu.BackgroundColor = [0.94 0.94 0.94];
            app.Menu.Position = [0 0 200 517];
            app.Menu.NodeCollapsedFcn = @app.CollapseMenu;
            app.Menu.SelectionChangedFcn = @app.SelectionMenu;
            
            app.Inicio = uitreenode(app.Menu);
            app.Inicio.Text = 'Inicio';
            
            app.AlexNet = uitreenode(app.Inicio);
            app.AlexNet.Text = 'AlexNet';
            
            app.AlexNetTraining = uitreenode(app.AlexNet);
            app.AlexNetTraining.Text = 'Training';
            
            app.AlexNetImageUpload = uitreenode(app.AlexNetTraining);
            app.AlexNetImageUpload.Text = 'Image Upload';
            
            app.AlexNetImageVisualization = uitreenode(app.AlexNetTraining);
            app.AlexNetImageVisualization.Text = 'Image Visualization';
            
            app.AlexNetModelTraining = uitreenode(app.AlexNetTraining);
            app.AlexNetModelTraining.Text = 'Model Training';
            
            app.GoogleNet = uitreenode(app.Inicio);
            app.GoogleNet.Text = 'GoogleNet';
            
            app.GoogleNetTraining = uitreenode(app.GoogleNet);
            app.GoogleNetTraining.Text = 'Training';
            
            app.GoogleNetImageUpload = uitreenode(app.GoogleNetTraining);
            app.GoogleNetImageUpload.Text = 'Image Upload';
            
            app.GoogleNetImageVisualization = uitreenode(app.GoogleNetTraining);
            app.GoogleNetImageVisualization.Text = 'Image Visualization';
            
            app.GoogleNetModelTraining = uitreenode(app.GoogleNetTraining);
            app.GoogleNetModelTraining.Text = 'Model Training';
            
            expand(app.Menu, 'all');
        end
        
        function select(app, event)
            
            import Controller.*;
            
            expand(app.Menu, 'all');
            
            switch event
                case Events.GUI_INICIO
                    app.Menu.SelectedNodes = [app.Inicio];
                case Events.GUI_PRINCIPAL_ALEXNET
                    app.Menu.SelectedNodes = [app.AlexNet];
                case Events.GUI_PRINCIPAL_GOOGLENET
                    app.Menu.SelectedNodes = [app.GoogleNet];
                case Events.GUI_TRAINING_ALEXNET
                    app.Menu.SelectedNodes = [app.AlexNetTraining];
                case Events.GUI_TRAINING_GOOGLENET
                    app.Menu.SelectedNodes = [app.GoogleNetTraining];
            end
        end
        
    end
end

