clc,clear,close all;
X=[1 1;-1 -1;1 -1;-1 1];
y=[1;1;-1;-1];
SVMModel=fitcsvm(X,y,'KernelFunction','rbf');%使用高斯核训练SVM
step=0.5;
[x1Grid,x2Grid]=meshgrid(-1.5:step:1.5,-1.5:step:1.5);
xGrid=[x1Grid(:),x2Grid(:)];%获取要判断的样本点
[~,scores]=predict(SVMModel,xGrid);%进行决策获取分类决策函数值
figure;
gscatter(X(:,1),X(:,2),y,'rb','*+');%按组绘制样本点
hold on
plot(X(SVMModel.IsSupportVector,1),X(SVMModel.IsSupportVector,2),'ko');
contour(x1Grid,x2Grid,reshape(scores(:,2),size(x1Grid)),[0 0],'k--');%绘制决策面
legend('-1','+1','SV');
hold off