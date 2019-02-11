function [theta,disp] = myAlign(im1,im2)
    [rows,cols] = size(im2);
    
    for theta = -60:60
        for disp = -12:12
            im2Rot = imrotate(im2,theta,'bilinear','crop');
            im2RotTrans = zeros(rows,cols);
      
            if(disp>0)
                im2RotTrans(:,disp+1:cols) = im2Rot(:,1:cols-disp);
            elseif(disp<0)
                im2RotTrans(:,1:cols+disp) = im2Rot(:,1-disp:cols);
            else
                im2RotTrans = im2Rot;
            end
            
            im1NonZero = im1(im1~=0 & im2RotTrans~=0);
            im2NonZero = im2RotTrans(im1~=0 & im2RotTrans~=0);
            
            numPoints = size(im1NonZero,1);
            im1NonZero = floor(im1NonZero/10);
            im2NonZero = floor(im2NonZero/10);
            jointHistogram = zeros(26);
            for i = 1:numPoints
                jointHistogram(im1NonZero(i)+1,im2NonZero(i)+1) = jointHistogram(im1NonZero(i)+1,im2NonZero(i)+1)+1;
            end
            
            jointHistogram = jointHistogram/sum(jointHistogram(:));
            jointHistogramNonZero = jointHistogram(jointHistogram>0);
            
            jointEntropy(theta+61,disp+13) = -1*sum(jointHistogramNonZero.*log2(jointHistogramNonZero));
        end
    end
    
    figure();
    surf(jointEntropy);
    minimumEntrophy = min(jointEntropy(:));
    [theta,disp] = find(abs(jointEntropy-minimumEntrophy) <= 0.00001);
    theta = theta-61;
    disp = disp-13;
end

