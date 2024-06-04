clc; clear; close all;

load fisheriris;%加载内置的 Fisher’s iris 数据集，其中包含了150个样本的花瓣和萼片的长度和宽度数据。

X = [5.5, 2.3, 4, 1.3];%新的样本 X

k=5;%这行代码设置 k-NN 算法中的 k 值为5，意味着将考虑最近的5个邻居。
N = length(meas);%计算数据集中样本的数量。
distance=pdist2(X, meas);%计算样本 X 与数据集中所有样本的欧氏距离。

[D, index] = sort(distance);%距离进行排序，并返回排序后的距离 D 和对应的索引 index。

disp('最近邻归类：');
celldisp(species(index(1)));%代码显示距离最近的样本的类别。

n1 = sum(count(species(index(1:k)), 'setosa'));
n2 = sum(count(species(index(1:k)), 'versicolor'));
n3 = sum(count(species(index(1:k)), 'virginica'));

if n1 > n2 && n1 > n3
    disp('k近邻归类：setosa');
elseif n2 > n1 && n2 > n3
    disp('k近邻归类：versicolor');
else
    disp('k近邻归类：virginica');
end