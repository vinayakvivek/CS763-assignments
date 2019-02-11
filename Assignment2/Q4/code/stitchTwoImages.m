function [resultImage] = stitchTwoImages(im1,im2,homography12)
    [rows1,cols1,channels] = size(im1);
    [rows2,cols2,~] = size(im2);
    resultImage = zeros(3*rows1,3*cols1,channels);
    resultImage(rows1+1:2*rows1,cols1+1:2*cols1,:) = im1;
    
    for r = 1:3*rows1
        for c = 1:3*cols1
            if (r<=rows1 || r>2*rows1 || c<=cols1 || c>2*cols1)
                relR = r-rows1;
                relC = c-cols1;
                im2Coord = homography12*[relC;relR;1];
                im2Coord = round([im2Coord(2,1)/im2Coord(3,1) im2Coord(1,1)/im2Coord(3,1)]);
                if(im2Coord(1)>0 && im2Coord(1)<=rows2 && im2Coord(2)>0 && im2Coord(2)<=cols2)
                    resultImage(r,c,:) = im2(im2Coord(1),im2Coord(2),:);
                end
            end
        end
    end
end

