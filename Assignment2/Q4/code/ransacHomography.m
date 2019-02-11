function [ H ] = ransacHomography( x1, x2, thresh )
    maxCount = -1;
    H = zeros(3,3);
    numPoints = size(x1,1);
    x1New = [x1(:,1)';x1(:,2)';ones(1,numPoints)];
    for iter = 1:10000
        randIndices = randsample(numPoints,4);
        currentH = homography(x1(randIndices,:),x2(randIndices,:));
        
        x2New = currentH*x1New;
        x2New(1,:) = x2New(1,:)./x2New(3,:);
        x2New(2,:) = x2New(2,:)./x2New(3,:);
        x2New = x2New(1:2,:)';
        count = sum(sqrt(sum((x2-x2New).^2,2))<thresh);
        
        if count>maxCount
            maxCount=count;
            H = currentH;
        end
    end
end

