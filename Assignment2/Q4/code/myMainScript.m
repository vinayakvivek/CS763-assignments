%% MyMainScript


%% Hill
tic;
im1 = imread('../input/hill/1.JPG');
im2 = imread('../input/hill/2.JPG');
im3 = imread('../input/hill/3.JPG');

im1Gray = rgb2gray(im1);
im2Gray = rgb2gray(im2);
im3Gray = rgb2gray(im3);

[features1,vpts1] = extractFeatures(im1Gray,detectSURFFeatures(im1Gray));
[features2,vpts2] = extractFeatures(im2Gray,detectSURFFeatures(im2Gray));
[features3,vpts3] = extractFeatures(im3Gray,detectSURFFeatures(im3Gray));

indexPairs12 = matchFeatures(features1,features2);
indexPairs23 = matchFeatures(features2,features3);

matchedPoints11 = vpts1(indexPairs12(:,1));
matchedPoints12 = vpts2(indexPairs12(:,2));
matchedPoints22 = vpts2(indexPairs23(:,1));
matchedPoints23 = vpts3(indexPairs23(:,2));

homography21 = ransacHomography(matchedPoints12.Location,matchedPoints11.Location,0.45);
homography23 = ransacHomography(matchedPoints22.Location,matchedPoints23.Location,0.45);

resultImage = mat2gray(stitchThreeImages(im1,im2,im3,homography21,homography23));

figure('units','normalized','outerposition',[0 0 1 1]);
imagesc(resultImage);
toc;

%% Ledge
tic;
im1 = imread('../input/ledge/1.JPG');
im2 = imread('../input/ledge/2.JPG');
im3 = imread('../input/ledge/3.JPG');

im1Gray = rgb2gray(im1);
im2Gray = rgb2gray(im2);
im3Gray = rgb2gray(im3);

[features1,vpts1] = extractFeatures(im1Gray,detectSURFFeatures(im1Gray));
[features2,vpts2] = extractFeatures(im2Gray,detectSURFFeatures(im2Gray));
[features3,vpts3] = extractFeatures(im3Gray,detectSURFFeatures(im3Gray));

indexPairs12 = matchFeatures(features1,features2);
indexPairs23 = matchFeatures(features2,features3);

matchedPoints11 = vpts1(indexPairs12(:,1));
matchedPoints12 = vpts2(indexPairs12(:,2));
matchedPoints22 = vpts2(indexPairs23(:,1));
matchedPoints23 = vpts3(indexPairs23(:,2));

homography21 = ransacHomography(matchedPoints12.Location,matchedPoints11.Location,0.45);
homography23 = ransacHomography(matchedPoints22.Location,matchedPoints23.Location,0.45);

resultImage = mat2gray(stitchThreeImages(im1,im2,im3,homography21,homography23));

figure('units','normalized','outerposition',[0 0 1 1]);
imagesc(resultImage);
toc;

%% Monument
tic;
im1 = imread('../input/monument/1.JPG');
im2 = imread('../input/monument/2.JPG');

im1Gray = rgb2gray(im1);
im2Gray = rgb2gray(im2);

[features1,vpts1] = extractFeatures(im1Gray,detectSURFFeatures(im1Gray));
[features2,vpts2] = extractFeatures(im2Gray,detectSURFFeatures(im2Gray));

indexPairs12 = matchFeatures(features1,features2);

matchedPoints11 = vpts1(indexPairs12(:,1));
matchedPoints12 = vpts2(indexPairs12(:,2));

homography12 = ransacHomography(matchedPoints11.Location,matchedPoints12.Location,0.45);

resultImage = mat2gray(stitchTwoImages(im1,im2,homography12));

figure('units','normalized','outerposition',[0 0 1 1]);
imagesc(resultImage);
toc;

%% Pier
tic;
im1 = imread('../input/pier/1.JPG');
im2 = imread('../input/pier/2.JPG');
im3 = imread('../input/pier/3.JPG');

im1Gray = rgb2gray(im1);
im2Gray = rgb2gray(im2);
im3Gray = rgb2gray(im3);

[features1,vpts1] = extractFeatures(im1Gray,detectSURFFeatures(im1Gray));
[features2,vpts2] = extractFeatures(im2Gray,detectSURFFeatures(im2Gray));
[features3,vpts3] = extractFeatures(im3Gray,detectSURFFeatures(im3Gray));

indexPairs12 = matchFeatures(features1,features2);
indexPairs23 = matchFeatures(features2,features3);

matchedPoints11 = vpts1(indexPairs12(:,1));
matchedPoints12 = vpts2(indexPairs12(:,2));
matchedPoints22 = vpts2(indexPairs23(:,1));
matchedPoints23 = vpts3(indexPairs23(:,2));

homography21 = ransacHomography(matchedPoints12.Location,matchedPoints11.Location,0.45);
homography23 = ransacHomography(matchedPoints22.Location,matchedPoints23.Location,0.45);

resultImage = mat2gray(stitchThreeImages(im1,im2,im3,homography21,homography23));

figure('units','normalized','outerposition',[0 0 1 1]);
imagesc(resultImage);
toc;

%% Own
tic;
im1 = imread('../input/own/1.JPG');
im2 = imread('../input/own/2.JPG');

im1Gray = rgb2gray(im1);
im2Gray = rgb2gray(im2);

[features1,vpts1] = extractFeatures(im1Gray,detectSURFFeatures(im1Gray));
[features2,vpts2] = extractFeatures(im2Gray,detectSURFFeatures(im2Gray));

indexPairs12 = matchFeatures(features1,features2);

matchedPoints11 = vpts1(indexPairs12(:,1));
matchedPoints12 = vpts2(indexPairs12(:,2));

homography12 = ransacHomography(matchedPoints11.Location,matchedPoints12.Location,0.45);

resultImage = mat2gray(stitchTwoImages(im1,im2,homography12));

figure('units','normalized','outerposition',[0 0 1 1]);
imagesc(resultImage);
toc;