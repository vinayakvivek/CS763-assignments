function [ resultImage ] = stitchThreeImages(im1,im2,im3,homography21,homography23)
    [rows1,cols1,~] = size(im1);
    [rows3,cols3,~] = size(im3);
    [rows2,cols2,channels2] = size(im2);
    resultImage = zeros(3*rows2,3*cols2,channels2);
    resultImage(rows2+1:2*rows2,cols2+1:2*cols2,:) = im2;
    
    for c = 1:3*cols2
        for r = 1:3*rows2
            if (r<=rows2 || r>2*rows2 || c<=cols2 || c>2*cols2)
                relR = r-rows2;
                relC = c-cols2;
                im1Coord = homography21*[relC;relR;1];
                im3Coord = homography23*[relC;relR;1];
                im1Coord = round([im1Coord(2,1)/im1Coord(3,1) im1Coord(1,1)/im1Coord(3,1)]);
                im3Coord = round([im3Coord(2,1)/im3Coord(3,1) im3Coord(1,1)/im3Coord(3,1)]);
                if(im1Coord(1)>0 && im1Coord(1)<=rows1 && im1Coord(2)>0 && im1Coord(2)<=cols1)
                    resultImage(r,c,:) = im1(im1Coord(1),im1Coord(2),:);
                else
                    if (im3Coord(1)>0 && im3Coord(1)<=rows3 && im3Coord(2)>0 && im3Coord(2)<=cols3)
                        resultImage(r,c,:) = im3(im3Coord(1),im3Coord(2),:);
                    end
                end
            end
        end
    end
end

