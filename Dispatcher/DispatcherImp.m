classdef DispatcherImp
    
    properties
        Ventana matlab.ui.Figure
        Principal matlab.ui.container.Panel
    end
    
    methods (Access = private)

    end
    
    methods (Access = public)
        function app = DispatcherImp
            app.Ventana = uifigure('Visible', 'off');
            app.Ventana.Position = [100 100 1000 600];
            app.Ventana.Name = 'Trabajo Fin de Grado';
            app.Ventana.Resize = false;
            app.Ventana.Visible = true;
            
            app.Principal = uipanel(app.Ventana);
            app.Principal.Position = [20 20 960 560];
        end
        
        function loadVista(app, event)
            
            import Vistas.*;
             
            delete(app.Principal.Children)
            
            switch event
                case Events.GUI_INICIO
                    InicioGUI(app.Principal);
                case Events.GUI_PRINCIPAL_ALEXNET
                    PrincipalGUI(app.Principal, Events.MODE_ALEXNET);
                case Events.GUI_PRINCIPAL_GOOGLENET
                    PrincipalGUI(app.Principal, Events.MODE_GOOGLENET);
            end
        end
    end
end

