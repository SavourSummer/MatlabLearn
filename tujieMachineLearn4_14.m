clc,clear,close all;
%对使用高斯盒模型的L2约束最小二乘学习法进行交叉已验证法
%高斯核=exp(-(x-c)^2/(2*h^2))
n=50;N=1000;x=linspace(-3,3,n)';X=linspace(-3,3,N)';

