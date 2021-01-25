classdef Controller
    
    methods (Static)
        
        function app = getInstance()
             persistent local;
             
             if isempty(local)
                local = ControllerImp();
             end
             
             app = local;
        end
        
    end
end

