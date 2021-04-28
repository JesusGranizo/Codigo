close all, clear all;

I = imread('VehiculosAlexNet\Muro\M60r.jpg');

I = imresize(I, [224 224]);

imwrite(I,'VehiculosGoogleNet\Muro\M60r.jpg')
