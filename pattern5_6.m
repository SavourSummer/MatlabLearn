clc,clear,close all;
load fisheriris.mat
%确定选择的两类数据在数据集的索引
index1=strcmp(species(:),'versicolor');
index2=strcmp(species(:),'virginica');

training1=meas(index1,3:4);
training2=meas(index2,3:4);%获取两类数据

training=[training1;training2];
index=[species(index1);species(index2)];%获取训练样本类别标记
gscatter(training(:,1),training(:,2),index,'rb','*o',5);%绘制样本
hold on
mu1=mean(training1);mu2=mean(training2);%计算样本均值
sigma1=cov(training1);sigma2=cov(training2)%计算协方差矩阵
minx=min(training(:,:));maxx=max(training(:,:))%确定样本的取值范围
step=0.1;
[x1Grid,x2Grid]=meshgrid(minx(:,1):step:maxx(:,1),minx(:,2):step:maxx(:,2));
xGrid=[x1Grid(:),x2Grid(:)];

for i=1:length(xGrid)
    gx(i)=(xGrid(i,:)-mu1)/(sigma1)*(xGrid(i,:)-mu1)'...
        -(xGrid(i,:)-mu2)/(sigma2)*(xGrid(i,:)-mu2)';%计算各样本对应判别函数取值
end
contour(x1Grid,x2Grid,reshape(gx,size(x1Grid)),[0 0],'k--');
legend('versicolor','virginica','决策面');
xlabel('花瓣长(cm)'),ylabel('花瓣宽(cm)');
hold off
