clc,clear,close all;
rng('default')
N=100;
x=normrnd(0,1,[N,1]);%生成单变量的正态分布数据
[muHat,sigmaHat]=normfit(x) %采样norfit函数估计均值和标准差
sigmaHat_MLE=sqrt(N-1/N)*sigmaHat
PATH=mle(x)