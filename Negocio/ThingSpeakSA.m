classdef ThingSpeakSA
    
    methods
        function app = ThingSpeakSA(event, transferThingSpeak)
            response = webwrite("http://api.brogame.es/thingspeak", "camera", transferThingSpeak.camera, "bus", transferThingSpeak.bus, "truck", transferThingSpeak.truck, "car", transferThingSpeak.car, "moto", transferThingSpeak.moto, "date", transferThingSpeak.date);
            if(response.error)
                msgbox(response.message, 'Error', 'error');
            else
                msgbox(response.message, 'Completado', 'help');
            end
            switch event
                case Events.SEND_TO_THINGSPEAK_ALEXNET
                    Controller.getInstance().execute(Events.GUI_VEHICLE_DETECTION_ALEXNET, nan);
                case Events.SEND_TO_THINGSPEAK_GOOGLENET
                    Controller.getInstance().execute(Events.GUI_VEHICLE_DETECTION_GOOGLENET, nan);
            end
        end
    end
end

