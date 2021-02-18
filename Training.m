classdef Training
    %TRAINING Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        modo        string
        transfer    TransferParametros
    end
    
    methods (Access = private)
        function trainingAlexNet(app)
            
            imds = imageDatastore('VehiculosAlexNet',...
                'IncludeSubfolders',true,...
                'LabelSource','foldernames');

            [imdsTrain,imdsValidation] = splitEachLabel(imds,0.9,'randomized');

            numTrainImages = numel(imdsTrain.Labels);
            idx = randperm(numTrainImages,64);
            
            for i = 1:64
                subplot(8,8,i)
                I = readimage(imdsTrain,idx(i));
                imshow(I)
            end
            
            net = alexnet;
            %analyzeNetwork(net)

            inputSize = net.Layers(1).InputSize;
            layersTransfer = net.Layers(1:end-3);
            numClasses = numel(categories(imdsTrain.Labels));

            layers = [
                layersTransfer
                fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
                softmaxLayer
                classificationLayer];

            pixelRange = [-30 30];
            imageAugmenter = imageDataAugmenter( ...
                'RandXReflection',true, ...
                'RandXTranslation',pixelRange, ...
                'RandYTranslation',pixelRange);

            options = trainingOptions('sgdm', ...
                'MiniBatchSize',300, ...
                'MaxEpochs',10, ...
                'InitialLearnRate',0.1, ...
                'ValidationData',imdsValidation, ...
                'ValidationFrequency',1, ...
                'ValidationPatience',Inf, ...
                'Verbose',false, ...
                'ExecutionEnvironment', 'auto', ...
                'Plots','training-progress');
            
            %analyzeNetwork(layers)
            
            netTransfer = trainNetwork(imdsTrain,layers,options);

            save netTransferAlex netTransfer

            [YPred,scores] = classify(netTransfer,imdsValidation);

            idx = randperm(numel(imdsValidation.Files),6);
            %figure
            for i = 1:6
                subplot(3,2,i)
                I = readimage(imdsValidation,idx(i));
                imshow(I)
                label = YPred(idx(i));
                title(string(label));
            end
            
            w1 = netTransfer.Layers(2).Weights;

            w1 = mat2gray(w1);
            w1 = imresize(w1,5);
            
            %figure
            %montage(w1)
            %title('First convolutional layer weights')
        end
        
        function trainingGoogleNet()
            
        end
    end
    
    methods
        function app = Training(event, transfer)
            app.transfer = transfer;
            switch event
                case Events.TRAINING_ALEXNET
                    app.modo = "alexnet";
                    app.trainingAlexNet();
                case Events.TRAINING_GOOGLENET
                    app.modo = "googlenet";
                    app.trainingGoogleNet();
            end
        end
    end
end

