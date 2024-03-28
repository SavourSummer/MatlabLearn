clc,clear,close all;
% 创建一个3x3矩阵
A = [1 2 3; 4 5 6; 7 8 9];

% 对矩阵进行奇异值分解
[U,S,V] = svd(A);

% 创建一个时间向量
t = linspace(0,2*pi,100);

% 创建一个在三维空间中移动的线
x = sin(t);
y = cos(t);
z = t;

% 创建一个新的图形窗口
figure

% 设置坐标轴的标签
xlabel('X')
ylabel('Y')
zlabel('Z')

% 显示图形
grid on
axis equal
title('3D Animation of a Line in SVD Transformed Space')

% 在三维空间中画出变换后的线
for i = 1:length(t)
    % 将线变换到新的坐标系
    new_points = V*[x(i); y(i); z(i)];

    % 画出变换后的线
    plot3(new_points(1,:), new_points(2,:), new_points(3,:))

    % 更新图形窗口
    drawnow

    % 暂停一段时间
    pause(0.1)
end
