classdef IdentifiedObject < handle
    properties
        XSupLeft         double
        XSupRight        double
        XInfLeft         double
        XInfRight        double
        YSupLeft         double
        YSupRight        double
        YInfLeft         double
        YInfRight        double
        frame           double
    end
    
    methods (Access = public)
        function app = IdentifiedObject(XSupLeft, XSupRight, XInfLeft, XInfRight, YSupLeft, YSupRight, YInfLeft, YInfRight, frame)
            app.XSupLeft = XSupLeft;
            app.XSupRight = XSupRight;
            app.XInfLeft = XInfLeft;
            app.XInfRight = XInfRight;
            app.YSupLeft = YSupLeft;
            app.YSupRight = YSupRight;
            app.YInfLeft = YInfLeft;
            app.YInfRight = YInfRight;
            app.frame = frame;
        end
        
        function back = isInside(app, XSupLeft, XSupRight, XInfLeft, XInfRight, YSupLeft, YSupRight, YInfLeft, YInfRight)
            back = false;
            if(XSupLeft > app.XInfLeft && YSupLeft > app.YInfLeft && XSupLeft < app.XSupRight && YSupLeft < app.YSupRight)
                back = true;
            elseif(XSupRight > app.XInfLeft && YSupRight > app.YInfLeft && XSupRight < app.XSupRight && YSupRight < app.YSupRight)
                back = true;
            elseif(XInfLeft > app.XInfLeft && YInfLeft > app.YInfLeft && XInfLeft < app.XSupRight && YInfLeft < app.YSupRight)
                back = true;
            elseif(XInfRight > app.XInfLeft && YInfRight > app.YInfLeft && XInfRight < app.XSupRight && YInfRight < app.YSupRight)
                back = true;
            end
            return;
        end
    end
end

