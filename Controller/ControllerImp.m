classdef ControllerImp
    
    methods
        
        function execute(app, event, data)
            
            import Events
            
            %if isa(data, 'double') && isnan(data)
                Dispatcher.getInstance().loadVista(event, data);
            %else
                CommandFactory.getInstance().execute(event, data);
            %end
        end
    end
end

