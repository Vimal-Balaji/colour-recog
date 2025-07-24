clc;clear;close all;
rimg = imread("image.jpg");

img=medfilt3(rimg);


hsvImg = rgb2hsv(img);


prompt = 'Enter target color (red, green, blue, yellow, cyan, magenta): ';
userColor = lower(input(prompt, 's'));

% Define hue ranges for basic colors (values between 0 and 1)
switch userColor
    case 'red'
        hueRange = [0.95, 1.0; 0.0, 0.05];  % Wrap-around for red
    case 'green'
        hueRange = [0.25, 0.45];
    case 'blue'
        hueRange = [0.55, 0.75];
    case 'yellow'
        hueRange = [0.12, 0.18];
    case 'cyan'
        hueRange = [0.45, 0.55];
    case 'magenta'
        hueRange = [0.85, 0.95];
    otherwise
        error('Unsupported color. Please choose from the listed options.');
end


H = hsvImg(:,:,1);
S = hsvImg(:,:,2);
V = hsvImg(:,:,3);

% Create mask based on hue range and threshold for saturation and brightness
mask = false(size(H));

for i = 1:size(hueRange,1)
    mask = mask | (H >= hueRange(i,1) & H <= hueRange(i,2));
end
mask = mask & (S > 0.3) & (V > 0.2); 


segmentedImg = bsxfun(@times, img, cast(mask, 'like', img));


figure;
imshowpair(img,segmentedImg,"montage");
title(['Segmented Image for Color: ', userColor]);
%}