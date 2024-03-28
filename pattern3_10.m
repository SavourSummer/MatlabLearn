clc,clear,close all;
rng("default")
N=200;
mu=0;   sd=0.8;%正态分布函数
x=normrnd(mu,sd,[N 1]);
x_values=-3:0.1:3;
px=pdf('Normal',x_values,mu,sd);%计算概率密度函数
plot(x_values,px,'Color','k');
[hist1,edge1]=histcounts(x,10,'Normalization','pdf')%设定10个区间进行估计，大间隔
[hist2,edge2]=histcounts(x,30,'Normalization','pdf')%设定30个区间进行估计，大间隔
hold on
histogram('BinEdges',edge1,'BinCounts',hist1,'FaceColor','w');
hold off
figure,plot(x_values,px,'Color','k','LineWidth',2);
hold on
histogram(x,30,'Normalization','pdf');
hold off


