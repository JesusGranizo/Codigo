classdef ControllerImp
    
    methods
        
        function execute(app, event, data)
            
            import Events
            
            if(isnan(data))
                Dispatcher.getInstance().loadVista(event);
            else
                disp(data);
            end
        end
    end
end

