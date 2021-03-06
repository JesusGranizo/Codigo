classdef TransferIdentified < handle
    properties
        BusIdentified
        CamionIdentified
        MotoIdentified
        DelanteraIdentified
        TraseraIdentified
        BusCount
        CamionCount
        MotoCount
        DelanteraCount
        TraseraCount
    end
    
    methods
        function app = TransferIdentified()
            app.BusIdentified = [];
            app.CamionIdentified = [];
            app.MotoIdentified = [];
            app.DelanteraIdentified = [];
            app.TraseraIdentified = [];
            app.BusCount = 0;
            app.CamionCount = 0;
            app.MotoCount = 0;
            app.DelanteraCount = 0;
            app.TraseraCount = 0;
        end
        
        function addItem(app, XSupLeft, XSupRight, XInfLeft, XInfRight, YSupLeft, YSupRight, YInfLeft, YInfRight, label, frame)
            exists = false;
            i = 1;
            switch label
                case 'Bus'
                    while i <= length(app.BusIdentified) && exists == false
                        identifiedObject = app.BusIdentified(i);
                        if identifiedObject.isInside(XSupLeft, XSupRight, XInfLeft, XInfRight, YSupLeft, YSupRight, YInfLeft, YInfRight)
                            app.BusIdentified(i) = IdentifiedObject(XSupLeft, XSupRight, XInfLeft, XInfRight, YSupLeft, YSupRight, YInfLeft, YInfRight, frame);
                            exists = true;
                        end
                        i = i+1;
                    end
                    if exists == false
                        app.BusIdentified = [app.BusIdentified, IdentifiedObject(XSupLeft, XSupRight, XInfLeft, XInfRight, YSupLeft, YSupRight, YInfLeft, YInfRight, frame)];
                    end
                case 'CamionFurgo'
                    while i <= length(app.CamionIdentified) && exists == false
                        identifiedObject = app.CamionIdentified(i);
                        if identifiedObject.isInside(XSupLeft, XSupRight, XInfLeft, XInfRight, YSupLeft, YSupRight, YInfLeft, YInfRight)
                            app.CamionIdentified(i) = IdentifiedObject(XSupLeft, XSupRight, XInfLeft, XInfRight, YSupLeft, YSupRight, YInfLeft, YInfRight, frame);
                            exists = true;
                        end
                        i = i+1;
                    end
                    if exists == false
                        app.CamionIdentified = [app.CamionIdentified, IdentifiedObject(XSupLeft, XSupRight, XInfLeft, XInfRight, YSupLeft, YSupRight, YInfLeft, YInfRight, frame)];
                    end
                case 'CocheDelantera'
                    while i <= length(app.DelanteraIdentified) && exists == false
                        identifiedObject = app.DelanteraIdentified(i);
                        if identifiedObject.isInside(XSupLeft, XSupRight, XInfLeft, XInfRight, YSupLeft, YSupRight, YInfLeft, YInfRight)
                            app.DelanteraIdentified(i) = IdentifiedObject(XSupLeft, XSupRight, XInfLeft, XInfRight, YSupLeft, YSupRight, YInfLeft, YInfRight, frame);
                            exists = true;
                        end
                        i = i+1;
                    end
                    if exists == false
                        app.DelanteraIdentified = [app.DelanteraIdentified, IdentifiedObject(XSupLeft, XSupRight, XInfLeft, XInfRight, YSupLeft, YSupRight, YInfLeft, YInfRight, frame)];
                    end
                case 'CocheTrasera'
                    while i <= length(app.TraseraIdentified) && exists == false
                        identifiedObject = app.TraseraIdentified(i);
                        if identifiedObject.isInside(XSupLeft, XSupRight, XInfLeft, XInfRight, YSupLeft, YSupRight, YInfLeft, YInfRight)
                            app.TraseraIdentified(i) = IdentifiedObject(XSupLeft, XSupRight, XInfLeft, XInfRight, YSupLeft, YSupRight, YInfLeft, YInfRight, frame);
                            exists = true;
                        end
                        i = i+1;
                    end
                    if exists == false
                        app.TraseraIdentified = [app.TraseraIdentified, IdentifiedObject(XSupLeft, XSupRight, XInfLeft, XInfRight, YSupLeft, YSupRight, YInfLeft, YInfRight, frame)];
                    end
                case 'Moto'
                    while i <= length(app.MotoIdentified) && exists == false
                        identifiedObject = app.MotoIdentified(i);
                        if identifiedObject.isInside(XSupLeft, XSupRight, XInfLeft, XInfRight, YSupLeft, YSupRight, YInfLeft, YInfRight)
                            app.MotoIdentified(i) = IdentifiedObject(XSupLeft, XSupRight, XInfLeft, XInfRight, YSupLeft, YSupRight, YInfLeft, YInfRight, frame);
                            exists = true;
                        end
                        i = i+1;
                    end
                    if exists == false
                        app.MotoIdentified = [app.MotoIdentified, IdentifiedObject(XSupLeft, XSupRight, XInfLeft, XInfRight, YSupLeft, YSupRight, YInfLeft, YInfRight, frame)];
                    end
            end
        end
        
        function cleanArrrays(app, frame)
            frame = frame - 7;
            i = 1;
            while i <= length(app.BusIdentified)
                if app.BusIdentified(i).frame < frame
                    app.BusIdentified(i) = [];
                    i = i-1;
                    app.BusCount = app.BusCount + 1;
                end
                i = i+1;
            end
            i = 1;
            while i <= length(app.CamionIdentified)
                if app.CamionIdentified(i).frame < frame
                    app.CamionIdentified(i) = [];
                    i = i-1;
                    app.CamionCount = app.CamionCount + 1;
                end
                i = i+1;
            end
            i = 1;
            while i <= length(app.MotoIdentified)
                if app.MotoIdentified(i).frame < frame
                    app.MotoIdentified(i) = [];
                    i = i-1;
                    app.MotoCount = app.MotoCount + 1;
                end
                i = i+1;
            end
            i = 1;
            while i <= length(app.DelanteraIdentified)
                if app.DelanteraIdentified(i).frame < frame
                    app.DelanteraIdentified(i) = [];
                    i = i-1;
                    app.DelanteraCount = app.DelanteraCount + 1;
                end
                i = i+1;
            end
            i = 1;
            while i <= length(app.TraseraIdentified)
                if app.TraseraIdentified(i).frame < frame
                    app.TraseraIdentified(i) = [];
                    i = i-1;
                    app.TraseraCount = app.TraseraCount + 1;
                end
                i = i+1;
            end
        end
            
    end
end

