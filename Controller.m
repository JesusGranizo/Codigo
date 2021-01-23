classdef Controller

    properties
        dispatcher Dispatcher
    end
    
    methods (Access = public)
        function app = Controller()
            import Dispatcher
            app.dispatcher = Dispatcher();
            app.dispatcher.loadVista("inicio");
        end
    end
end

