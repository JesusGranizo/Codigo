classdef Dispatcher
    
    methods (Static)
        
        function app = getInstance()
             persistent local;
             
             if isempty(local)
                local = DispatcherImp();
             end
             
             app = local;
        end
    end
    
end

