classdef CommandFactoryImp
    methods
        function execute(app, event, data)
            import src.Context.*
            switch event
                case Events.TRAINING_ALEXNET
                    Training(event, data);
                case Events.TRAINING_GOOGLENET
                    Training(event, data);
                case Events.VISUALIZATION_ALEXNET
                    Visualization(event);
                case Events.VISUALIZATION_GOOGLENET
                    Visualization(event);
                case Events.SEND_TO_THINGSPEAK_ALEXNET
                    ThingSpeakSA(event, data);
                case Events.SEND_TO_THINGSPEAK_GOOGLENET
                    ThingSpeakSA(event, data);
            end     
        end
    end
end