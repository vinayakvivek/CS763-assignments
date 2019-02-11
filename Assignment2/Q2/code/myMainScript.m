%% Rigit Transform between 2 sets of 3D Points

% Load Data
img = imread('../input/wembley.jpeg');

% Get four points of box
img = mat2gray(img);
figure('units','normalized','outerposition',[0 0 1 1]);
imagesc(img);
title('Choose the 4 box corners in order');
[imageX,imageY] = ginput(4);
close();

% Data
objectSpace = [0 0; 0 18; 44 18; 44 0];
imageSpace = [imageX imageY];

% Get homography
H = homography(objectSpace,imageSpace);

% Get three corners
figure('units','normalized','outerposition',[0 0 1 1]);
imagesc(img);
title('Choose 3 corners of field in order');
[imageX,imageY] = ginput(3);
close();

% Calculate field size
imageCorners = [imageX';imageY';ones(1,3)];
objectCorners = H\imageCorners;
corner1 = [objectCorners(1,1)/objectCorners(3,1) objectCorners(2,1)/objectCorners(3,1)];
corner2 = [objectCorners(1,2)/objectCorners(3,2) objectCorners(2,2)/objectCorners(3,2)];
corner3 = [objectCorners(1,3)/objectCorners(3,3) objectCorners(2,3)/objectCorners(3,3)];
distX = sqrt(sum((corner1-corner2).^2));
distY = sqrt(sum((corner2-corner3).^2));
fprintf('The dimensions of the field is %f yd x %f yd\n',distX,distY);

%% Estimated dimensions found during our test run : 74.94*111.45