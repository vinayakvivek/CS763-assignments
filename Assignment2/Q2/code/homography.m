function [ H ] = homography( p1, p2 )
% p1 and p2 are assumed to be two sets of 2D points with equal cardinality and returns a 3x3 homography matrix H
% such that p2 = H*p1
    n = size(p1,1);
    M = zeros(2*n,9);
    for i = 1:n
        M(2*i-1,:) = [-p1(i,:) -1 0 0 0 p2(i,1)*p1(i,:) p2(i,1)];
        M(2*i,:) = [0 0 0 -p1(i,:) -1 p2(i,2)*p1(i,:) p2(i,2)];
    end
    [~,~,V] = svd(M);
    H = reshape(V(:,9),[3,3])';
end

