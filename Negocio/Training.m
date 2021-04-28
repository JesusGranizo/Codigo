classdef Training

    properties
        modo            string
        transfer        TransferParametros
        plotRows        double
        plotColumns     double
    end
    
    methods (Access = private)
        function trainingAlexNet(app)
            
            imds = imageDatastore('VehiculosAlexNet',...
                'IncludeSubfolders',true,...
                'LabelSource','foldernames');

            [imdsTrain,imdsValidation] = splitEachLabel(imds,0.9,'randomized');

            numTrainImages = numel(imdsTrain.Labels);
            
            if app.transfer.TrainingImages
                
                idx = randperm(numTrainImages,app.transfer.NumTrainingImages);
            
                app = app.calcPlot(1);

                for i = 1:app.transfer.NumTrainingImages
                    subplot(app.plotRows,app.plotColumns,i)
                    I = readimage(imdsTrain,idx(i));
                    imshow(I)
                end
            end
            
            net = alexnet;
            
            if app.transfer.DisplayNet
                analyzeNetwork(net)
            end

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
                'MiniBatchSize',app.transfer.MiniBatchSize, ...
                'MaxEpochs',app.transfer.Epochs, ...
                'InitialLearnRate',app.transfer.InitialLearnRate, ...
                'ValidationData',imdsValidation, ...
                'ValidationFrequency',app.transfer.ValidationFrequency, ...
                'ValidationPatience',app.transfer.ValidationPatience, ...
                'Verbose',false, ...
                'ExecutionEnvironment', 'cpu', ...
                'Plots','training-progress');
            
            if app.transfer.DisplayLayers
                analyzeNetwork(layers)
            end
            
            netTransfer = trainNetwork(imdsTrain,layers,options);

            save netTransferAlex netTransfer

            [YPred,scores] = classify(netTransfer,imdsValidation);            
            
            if app.transfer.ValidationImages
                
                idx = randperm(numel(imdsValidation.Files),app.transfer.NumValidationImages);
            
                app = app.calcPlot(2);
                
                for i = 1:app.transfer.NumValidationImages
                    subplot(app.plotRows,app.plotColumns,i)
                    I = readimage(imdsValidation,idx(i));
                    imshow(I)
                    label = YPred(idx(i));
                    title(string(label));
                end
            end
            
            w1 = netTransfer.Layers(2).Weights;

            w1 = mat2gray(w1);
            w1 = imresize(w1,5);
            
            if app.transfer.DisplayNetworkHeights
                figure
                montage(w1)
                title('First convolutional layer weights')
            end
        end
        
        function trainingGoogleNet(app)
            imds = imageDatastore('VehiculosGoogleNet',...
                'IncludeSubfolders',true,...
                'LabelSource','foldernames');

            [imdsTrain,imdsValidation] = splitEachLabel(imds,0.9,'randomized');

            numTrainImages = numel(imdsTrain.Labels);
            
            if app.transfer.TrainingImages
                
                idx = randperm(numTrainImages,app.transfer.NumTrainingImages);
            
                app = app.calcPlot(1);

                for i = 1:app.transfer.NumTrainingImages
                    subplot(app.plotRows,app.plotColumns,i)
                    I = readimage(imdsTrain,idx(i));
                    imshow(I)
                end
            end

            net = googlenet;

            lgraph = layerGraph(net);

            newlgraph = removeLayers(lgraph,'loss3-classifier');
            newlgraph = removeLayers(newlgraph,'prob');
            newlgraph = removeLayers(newlgraph,'output');

            numClasses = numel(categories(imdsTrain.Labels));

            larray = [
                fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20, 'Name','fc1')
                softmaxLayer('Name','soft')
                classificationLayer('Name','c1')];

            newlgraph1 = addLayers(newlgraph,larray);

            lgraphFinal = connectLayers(newlgraph1,'pool5-drop_7x7_s1','fc1');

            if app.transfer.DisplayNet
                analyzeNetwork(lgraphFinal)
            end
            
            pixelRange = [-30 30];
            imageAugmenter = imageDataAugmenter( ...
                'RandXReflection',true, ...
                'RandXTranslation',pixelRange, ...
                'RandYTranslation',pixelRange);
            
            options = trainingOptions('sgdm', ...
                'MiniBatchSize',app.transfer.MiniBatchSize, ...
                'MaxEpochs',app.transfer.Epochs, ...
                'InitialLearnRate',app.transfer.InitialLearnRate, ...
                'ValidationData',imdsValidation, ...
                'ValidationFrequency',app.transfer.ValidationFrequency, ...
                'ValidationPatience',app.transfer.ValidationPatience, ...
                'Verbose',false, ...
                'ExecutionEnvironment', 'cpu', ...
                'Plots','training-progress');

            netTransfer = trainNetwork(imdsTrain,lgraphFinal,options);

            save netTransferGoogle netTransfer

            [YPred,scores] = classify(netTransfer,imdsValidation);

            if app.transfer.ValidationImages
                
                idx = randperm(numel(imdsValidation.Files),app.transfer.NumValidationImages);
            
                app = app.calcPlot(2);
                
                for i = 1:app.transfer.NumValidationImages
                    subplot(app.plotRows,app.plotColumns,i)
                    I = readimage(imdsValidation,idx(i));
                    imshow(I)
                    label = YPred(idx(i));
                    title(string(label));
                end
            end
            
            w1 = netTransfer.Layers(2).Weights;

            w1 = mat2gray(w1);
            w1 = imresize(w1,5);
            
            if app.transfer.DisplayNetworkHeights
                figure
                montage(w1)
                title('First convolutional layer weights')
            end
        end
        
        function app = calcPlot(app, mode)
            
            aux = 2;
            
            if mode == 1
                aux = app.transfer.NumTrainingImages
            else
                aux = app.transfer.NumValidationImages
            end
            
            switch aux
                case 2
                    app.plotRows = 2;
                    app.plotColumns = 1;
                case 4
                    app.plotRows = 2;
                    app.plotColumns = 2;
                case 6
                    app.plotRows = 3;
                    app.plotColumns = 2;
                case 8
                    app.plotRows = 4;
                    app.plotColumns = 2;
                case 9
                    app.plotRows = 3;
                    app.plotColumns = 3;
                case 12
                    app.plotRows = 4;
                    app.plotColumns = 3;
                case 16
                    app.plotRows = 4;
                    app.plotColumns = 4;
                case 20
                    app.plotRows = 5;
                    app.plotColumns = 4;
                case 25
                    app.plotRows = 5;
                    app.plotColumns = 5;
                case 30
                    app.plotRows = 6;
                    app.plotColumns = 5;
                case 42
                    app.plotRows = 7;
                    app.plotColumns = 6;
                case 56
                    app.plotRows = 8;
                    app.plotColumns = 7;
                case 64
                    app.plotRows = 8;
                    app.plotColumns = 8;
            end
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

