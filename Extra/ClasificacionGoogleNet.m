%% Estimating Optical Flow
% This example uses the Farneback Method to to estimate the direction and speed of moving
% cars in the video
% Copyright 2018 The MathWorks, Inc.
%% Read the video into MATLAB
close all; clear all;

%% White balance
%https://es.mathworks.com/help/images/ref/illumwhite.html

% sssMPEG = '..\Videos\Video1.mp4';
% videoMPEG = VideoWriter(sssMPEG,'MPEG-4');
% open(videoMPEG)

load netTransferGoogle

sz = netTransfer.Layers(1).InputSize;

[aa bb]=uigetfile({'*.*','All files'});
NombreVideo = strcat(bb,aa);

vidReader = VideoReader(NombreVideo);

opticFlow = opticalFlowFarneback;
%opticFlow = opticalFlowLK;
reset(opticFlow);

frameRGB = read(vidReader,1);
[M,N,s] = size(frameRGB);
frameRGBprev = frameRGB; 
frameGrayprev = rgb2gray(frameRGB);

NFrames = vidReader.NumberOfFrames;
%% Estimate Optical Flow of each frame
start = 500;
for i=start:1:NFrames %despreciamos el 
  %while hasFrame(vidReader)
  frameRGB = read(vidReader,i);
  %frameRGBcopia = frameRGB;
  %frameRGB = readFrame(vidReader);
  frameGray = rgb2gray(frameRGB);
  flow = estimateFlow(opticFlow,frameGray);
  figure(1);imshow(frameRGB);impixelinfo
  hold on
  % Plot the flow vectors
  plot(flow,'DecimationFactor',[25 25],'ScaleFactor', 2)
  % Find the handle to the quiver object
  q = findobj(gca,'type','Quiver');
  % Change the color of the arrows to red
  q.Color = 'r';
  drawnow
  hold off
  
  if i > 2
    MagnitudFlow    = mat2gray(flow.Magnitude);
    OrientacionFlow = flow.Orientation;
    level = mean2(MagnitudFlow)+std2(MagnitudFlow);
    BWMagFlow = MagnitudFlow > level;

    [Labels,Nlabels] = bwlabel(BWMagFlow);
    %figure(3); imagesc(Labels); impixelinfo; colorbar
    RProp   = regionprops(Labels,'all');
    RPropRed   = regionprops(Labels,frameRGB(:,:,1),'all');
    RPropGreen = regionprops(Labels,frameRGB(:,:,2),'all');
    RPropBlue  = regionprops(Labels,frameRGB(:,:,3),'all');
    RPropOrientacion  = regionprops(Labels,OrientacionFlow,'all');
    
    % Habría que trabajar un poco esto para restringir más las áreas
    % candidatas
    AreasCandidatas = zeros(1,Nlabels);
    for j=1:1:Nlabels
      if RProp(j).Area > 500
        AreasCandidatas(j) = 1;
      end
    end
    
  amp = 0;
  for h=1:1:Nlabels
    if AreasCandidatas(h) == 1
      XSupIzda =  round(RProp(h).BoundingBox(1)+amp);
      if XSupIzda <=0; XSupIzda = 1; end
      YSupIzda =  round(RProp(h).BoundingBox(2)+amp);  
      if YSupIzda <=0; YSupIzda = 1; end
    
      XSupDcha =  round(XSupIzda + RProp(h).BoundingBox(3) + amp);
      if XSupDcha > N; XSupDcha = N; end
      YSupDcha =  YSupIzda; 
     
      XInfIzda =  XSupIzda;
      YInfIzda =  round(YSupIzda + RProp(h).BoundingBox(4) + amp);
      if YInfIzda > M; YInfIzda = M; end

      XInfDcha =  XSupDcha; 
      YInfDcha =  YInfIzda;
    
      Recorte = frameRGB(YSupIzda:1:YInfIzda,XSupIzda:1:XSupDcha,:);
      RecorteBW = BWMagFlow(YSupIzda:1:YInfIzda,XSupIzda:1:XSupDcha,:);

      [aar, bbr, ssr] = size(Recorte);
      R = imresize(Recorte, [sz(1) sz(2)], 'bilinear');       
      %figure(4); imshow(R); hold on
      
      %% Clasifcación propiamente dicha
      [label, Error]  = classify(netTransfer,R);
      [MEt,MaxEt] = max(Error);
      disp('Label ='); disp(label)
      disp('Error ='); disp(Error)
      
      % Aquí debemos tomar una decisión para determinar si el coche va en
      % buen sentido o mal. Teniendo en cuenta la posición de la cámara en
      % la carretera. Por la parte izquierda el flujo tendrá una
      % orientación diferente a la derecha. 
      Orientacion = RPropOrientacion(h).MeanIntensity;

      if (label ~= 'Asfalto') && (label ~= 'Lineas') && (label ~= 'Muro')... 
         && (MEt >= 0.5)... 
         && RPropOrientacion(h).Centroid(2) > 500 && RPropOrientacion(h).Centroid(2) < 950 
        %figure(5); bar(Error)
        switch label
        case 'Bus'
          color = 'yellow'; texto = 'Bus';
        case 'CamionFurgo'
          color = 'white'; texto = 'Camion-furgo';
        case 'CocheDelantera'
          color = 'blue'; texto = 'Car Frontal';
        case 'CocheTrasera'
          color = 'red'; texto = 'Car Trasera';
        case 'Moto'
          color = 'green'; texto = 'Moto';
        case 'Asfalto'
          color = 'black'; texto = 'Asfalto';
        case 'Lineas'
          color = 'black'; texto = 'Lineas';
        case 'Muro'
          color = 'black'; texto = 'Muro';
        end
        figure(1); hold on; text(XSupDcha,YSupDcha,texto)
        line([XSupIzda,XSupDcha],[YSupIzda,YSupDcha],'LineWidth',3,'Color',color)
        line([XSupIzda,XInfIzda],[YSupIzda,YInfIzda],'LineWidth',3,'Color',color)
        line([XSupDcha,XInfDcha],[YSupDcha,YInfDcha],'LineWidth',3,'Color',color)
        line([XInfIzda,XInfDcha],[YInfIzda,YInfDcha],'LineWidth',3,'Color',color)
        hold off
        
      end
    end
  end
  end
%   saveas(figure(1),'Figura1.bmp');
%   frameFigure = imread('Figura1.bmp');
%   if i > start+2
%     writeVideo(videoMPEG,frameFigure);
%   end 
  
end
% close(videoMPEG); %se cierra el video

