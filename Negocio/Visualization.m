classdef Visualization
    %VISUALIZATION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        modo            string
    end
    
    methods
        function app = Visualization(event)
            switch event
                case Events.VISUALIZATION_ALEXNET
                    app.modo = "alexnet";
                    winopen('./VehiculosAlexNet/');
                    Controller.getInstance().execute(Events.GUI_GOTRAINING_ALEXNET, nan);
                case Events.VISUALIZATION_GOOGLENET
                    app.modo = "googlenet";
                    winopen('./VehiculosGoogleNet/');
                    Controller.getInstance().execute(Events.GUI_GOTRAINING_GOOGLENET, nan);
            end
        end
    end
end

