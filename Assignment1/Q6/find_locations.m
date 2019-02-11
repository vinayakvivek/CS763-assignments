close all
clc
clear
im = double(imread('Painting.jpg'))./255;
% figure
% imshow(im)

hsvI = rgb2hsv(im);
hueI = round(hsvI(:, :, 1) * 360);
yellow = double((hueI > 56) & (hueI <= 60));
green = double(im(:,:,2) > 0.9);

% R -> (685, 422), (430, 422)
% H -> (790, 745), (217, 745)
% horizon -> (580)

figure
im(430:685, 422, :) = 0;
im(217:790, 745, :) = 0;
im(580, :, :) = 0;
imshow(im)

% imshow(yellow(217: 790, 600:765))
% imshow(green(580:600, :));









