classdef Menu
    
    properties
        Titulo matlab.ui.control.Label
    end
    
    methods (Access = private)

    end
    
    methods (Access = public)

        function app = Menu(panel)
            app.Titulo = uilabel(panel);
            app.Titulo.FontSize = 35;
            app.Titulo.FontWeight = 'bold';
            app.Titulo.Position = [40 480 500 54];
            app.Titulo.Text = 'Menú';
        end
        
        function setTitulo(app, titulo)
            app.Titulo.Text = titulo;
        end
        
        function delete(app)
            app.Titulo.delete;
        end
    end
end

