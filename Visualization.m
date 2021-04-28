classdef Visualization
    %VISUALIZATION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        modo            string
    end
    
    methods
        function app = Visualization(event)
            switch event
                case Events.GUI_VISUALIZATION_ALEXNET
                    app.modo = "alexnet";
                    winopen('VehiculosAlexNet/');
                case Events.GUI_VISUALIZATION_GOOGLENET
                    app.modo = "googlenet";
                    winopen('VehiculosGoogleNet/');
            end
        end
    end
end

