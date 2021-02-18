classdef TransferParametros
    
    properties
        TrainingImages          logical
        NumTrainingImages       double
        ValidationImages        logical
        NumValidationImages     double
        DisplayNet              logical
        DisplayLayers           logical
        DisplayNetworkHeights   logical
        MiniBatchSize           double
        Epochs                  double
        ValidationFrequency     double
        ValidationPatience      double
        InitialLearnRate        double
    end
    
    methods
        function app = TransferParametros(TrainingImages, NumTrainingImages, ValidationImages, NumValidationImages, DisplayNet, DisplayLayers, DisplayNetworkHeights, MiniBatchSize, Epochs, ValidationFrequency, ValidationPatience, InitialLearnRate)
            app.TrainingImages = TrainingImages;
            app.NumTrainingImages = NumTrainingImages;
            app.ValidationImages = ValidationImages;
            app.NumValidationImages = NumValidationImages;
            app.DisplayNet = DisplayNet;
            app.DisplayLayers = DisplayLayers;
            app.DisplayNetworkHeights = DisplayNetworkHeights;
            app.MiniBatchSize = MiniBatchSize;
            app.Epochs = Epochs;
            app.ValidationFrequency = ValidationFrequency;
            app.ValidationPatience = ValidationPatience;
            app.InitialLearnRate = InitialLearnRate;
        end
    end
end

