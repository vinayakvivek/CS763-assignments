clear;
clc;

obj_points_orig = [
    [0, 0, 3, 1]
    [0, 0, 2, 1]
    [0, 0, 1, 1]
    [-1, -1, 0, 1]
    [-2, -1, 0, 1]
    [-3, -1, 0, 1]
];
obj_points = obj_points_orig;

obj_trans = [
    [1 0 0 1]
    [0 1 0 0.5]
    [0 0 1 -1]
    [0 0 0 1]
];
t = (obj_trans * obj_points')';
t = t(:, 1:3);
s = sqrt(3) * 6 / sum(sqrt(sum(t.^2, 2)));
obj_scale = [s 0 0 0; 0 s 0 0; 0 0 s 0; 0 0 0 1];
U = obj_scale * obj_trans;
obj_points = (U * obj_points')';

img_points_orig = [
    [1.7746 1.0966, 1]
    [1.4746 1.0846, 1]
    [1.2287 1.0846, 1]
    [2.5244 1.5165 1]
    [2.7703 1.4625 1]
    [2.9743 1.4265 1]
];
img_points = img_points_orig;
img_trans = [
    [1 0 -2.1245]
    [0 1 -1.2785]
    [0 0 1]
];

t = (img_trans * img_points')';
t = t(:, 1:2);
s = sqrt(2) * 6 / sum(sqrt(sum(t.^2, 2)));
img_scale = [s 0 0; 0 s 0; 0 0 1];
T = img_scale * img_trans;
img_points = (T * img_points')';


M = zeros(12, 12);
for i = 1:6
    p = obj_points(i, 1:3);
    x = img_points(i, 1);
    y = img_points(i, 2);
    M(2*i-1, :) = [-p(1), -p(2), -p(3), -1, 0, 0, 0, 0, p(1)*x, p(2)*x, p(3)*x, x];
    M(2*i, :) = [0, 0, 0, 0, -p(1), -p(2), -p(3), -1, p(1)*y, p(2)*y, p(3)*y, y];
end

[~,S,V] = svd(M);
p = V(:, 12);
P_ = [p(1) p(2) p(3) p(4); p(5) p(6) p(7) p(8); p(9) p(10) p(11) p(12)];
P = inv(T) * P_ * U;

H = P(:, 1:3);
h = P(:, 4);
X_o = -inv(H) * h;

[Q,R] = qr(H);
R_ = Q';
K_ = inv(R);
K_ = K_ / K_(3,3);

% X_o, R_, K_

% verfication 
points = P * obj_points_orig';
for i = 1:6
    points(:,i) = points(:,i) ./ points(3,i); 
end

diff = points' - img_points_orig;
RMSE = mean(sum(diff.^2, 2));
RMSE


