classdef TransferThingSpeak < handle
    properties
        camera      string
        bus         double
        truck       double
        car         double
        moto        double
        date        string
    end
    
    methods
        function app = TransferThingSpeak(camera, bus, truck, car, moto, date, time)
            app.camera = camera;
            app.bus = bus;
            app.truck = truck;
            app.car = car;
            app.moto = moto;
            app.date = append(num2str(year(date),'%04.f'), '-', num2str(month(date),'%02.f'), '-', num2str(day(date),'%02.f'), ' ', time);
        end
    end
end

