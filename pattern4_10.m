clc,clear,close all;
X=[0 0 0;1 0 0;1 0 1;1 1 0;0 0 1;0 1 1;0 1 0;1 1 1];
y=[1;1;1;1;-1;-1;-1;-1];
SVMModel=fitcsvm(X,y);%训练SVM
sv=SVMModel.SupportVectors;
s=SVMModel.KernelParameters;
W=SVMModel.Beta/s.Scale;%权向量
w0=SVMModel.Bias;%偏移量w0
pattern=[0 0.6 0.8];%待分类模式
[label,scores]=predict(SVMModel,pattern);%决策
[x1,x2]=meshgrid(0:.1:1,0:.1:1);
x3=-(W(1)*x1+W(2)*x2+w0)/W(3);%计算分类平面上的点，用于绘制分类平面
pos=y<0;
scatter3(X(pos>0,1),X(pos>0,2),X(pos>0,3),'r*');%绘制二类的点
hold on
scatter3(X(~pos,1),X(~pos,2),X(~pos,3),'g>');%绘制一类的点
scatter3(sv(:,1),sv(:,2),sv(:,3),60,'ko');%绘制支持向量
scatter3(pattern(1),pattern(2),pattern(3),60,'b<');%绘制待测样本
mesh(x1,x2,x3);%绘制分类平面
hold off
box on
