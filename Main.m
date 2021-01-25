classdef Main
    
    methods
        function app = Main()
            clc; clear;
            clear all;
            Controller.getInstance().execute(Events.GUI_INICIO, nan);
        end

    end
end

