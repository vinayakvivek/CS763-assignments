%% Barbara - negative barabara images
tic;
im1 = imread('../input/barbara.png');
im2 = imread('../input/negative_barbara.png');

im2 = imrotate(im2,23.5,'bilinear','crop');
[rows2,cols2] = size(im2);
im2Trans = zeros(rows2,cols2);
im2Trans(:,1:cols2-3) = im2(:,4:cols2);
randomNoise = round(rand(rows2,cols2)*8);
im2 = im2Trans + randomNoise;
im2(im2 < 0) = 0; 
im2(im2 > 255)= 255;

[theta2,disp2] = myAlign(im1,im2);

fprintf('For barbara and negative barbara images the theta was %d and t_x was %d\n',theta2,disp2);

toc;

%% Flash - No flash images
tic;
im3 = rgb2gray(imread('../input/flash1.jpg'));
im4 = rgb2gray(imread('../input/noflash1.jpg'));

im4 = imrotate(im4,23.5,'bilinear','crop');
[rows4,cols4] = size(im4);
im4Trans = zeros(rows4,cols4);
im4Trans(:,1:cols4-3) = im4(:,4:cols4);
randomNoise = round(rand(rows4,cols4)*8);
im4 = im4Trans + randomNoise;
im4(im4 < 0) = 0;
im4(im4 > 255)= 255;

[theta4,disp4] = myAlign(im3,im4);

fprintf('For flash and non flash image theta was %d and t_x was %d\n',theta4,disp4');

toc;