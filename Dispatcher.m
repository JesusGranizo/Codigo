classdef Dispatcher
    
    properties
        Ventana matlab.ui.Figure
        Principal matlab.ui.container.Panel
    end
    
    methods (Access = private)

    end
    
    methods (Access = public)
        function app = Dispatcher
            app.Ventana = uifigure('Visible', 'off');
            app.Ventana.Position = [100 100 1000 600];
            app.Ventana.Name = 'Trabajo Fin de Grado';
            app.Ventana.Resize = false;
            app.Ventana.Visible = true;
            
            app.Principal = uipanel(app.Ventana);
            app.Principal.Position = [20 20 960 560];
        end
        
        function loadVista(app, index)
            
            import Vistas.*;
            index = lower(index);   
            delete(app.Principal.Children)
            
            switch index
                case "inicio"
                    InicioVista(app.Principal);
                case "menu"
                    Menu(app.Principal);
            end
        end
    end
end

