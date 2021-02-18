classdef CommandFactoryImp
    methods
        function execute(app, event, data)
            import src.Context.*
            switch event
                case Events.TRAINING_ALEXNET
                    Training(event, data);
                case Events.TRAINING_GOOGLENET
                    Training(event, data);
            end     
        end
    end
end