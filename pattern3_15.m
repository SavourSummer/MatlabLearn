clc,clear,close all;
load fisheriris
%最小错误率贝叶斯决策
training=meas(:,3:4);%"meas" 通常是指鸢尾花数据集 (Iris dataset) 的测量部分。这个数据集包含了每个样本的四个特征测量值：萼片长度、萼片宽度、花瓣长度和花瓣宽度。这里是数据降维
X_se=training(ismember(species,'setosa'),:);
X_ve=training(ismember(species,'versicolor'),:);
X_vi=training(ismember(species,'virginica'),:);%分别表示3类数据
xmin=min(training,[],1);
xmax=max(training,[],1);%确定估计点取值数据,[] 表示没有第二个输入数组参与比较，1 表示沿着第一维（即行）进行操作，找出每列的最小值。
dx=0.1;%设置网格间距的语句
[x1,x2]=ndgrid(xmin(:,1):dx:xmax(:,1),xmin(:,2):dx:xmax(:,2));%生成一个网格，用于计算概率密度函数。
%目的是将二维网格坐标 x1 和 x2 转换为一列向量，并将它们组合成一个新的矩阵 XI
dim=size(x1');%计算转置后的 x1 的大小，并将结果存储在 dim 中
x1 = x1(:,:)';
x2 = x2(:,:)';
XI = [x1(:) x2(:)];%确定二维空间采样点。新的矩阵 XI，它的每一行包含了一个网格点的坐标

Pxe_se= mvksdensity(X_se,XI,'Bandwidth',1);
Pxe_ve= mvksdensity(X_ve,XI,'Bandwidth',1);
Pxe_vi= mvksdensity(X_vi,XI,'Bandwidth',1);%用核密度估计法进行概率密度估计

%在前面的代码中，Pxe_se 是通过 mvksdensity 函数计算得到的概率密度，
% 它是一个列向量。然后，reshape 函数将这个列向量重新塑形为一个二维矩阵，
% 这个矩阵的大小由 dim 指定，dim 是原始网格的大小。
%
Pxe_se=reshape(Pxe_se,dim);%将一维概率密度向量表达为二维格式
Pxe_ve=reshape(Pxe_ve,dim);
Pxe_vi=reshape(Pxe_vi,dim);

subplot(131),mesh(xmin(:,1):dx:xmax(:,1),xmin(:,2):dx:xmax(:,2),Pxe_se);
subplot(132),mesh(xmin(:,1):dx:xmax(:,1),xmin(:,2):dx:xmax(:,2),Pxe_ve);
subplot(133),mesh(xmin(:,1):dx:xmax(:,1),xmin(:,2):dx:xmax(:,2),Pxe_vi);

X=[4.8 3.5 1.5 0.2];%定义了一个新的样本 X
X=X(3:4);
pos=round((X-xmin)/dx)+1;%计算 X 在网格中的位置。首先，它计算 X 和 xmin 的差，然后除以网格间距 dx，然后四舍五入到最近的整数，最后加 1。这是因为 MATLAB 的索引是从 1 开始的，而不是从 0 开始
P_se=Pxe_se(pos(2),pos(1));%获取1待决策1样本在3类概率密度中的位置
P_ve=Pxe_ve(pos(2),pos(1));
P_vi=Pxe_vi(pos(2),pos(1));

maxP=max([P_se P_ve P_vi]);
if P_se==maxP
    disp('样本为settosa类');
elseif P_ve==maxP
    disp('样本为versicolor类');
else
    disp('样本为virginica类');
end

count_se=0;
count_ve=0;
count_vi=0;
for i=1:150        %对所有样本进行测试2，计算总体识别率
    X=training(i,:);
    pos=round((X-xmin)/dx)+1;
    P_se=Pxe_se(pos(2),pos(1));%获取1待决策1样本在3类概率密度中的位置
    P_ve=Pxe_ve(pos(2),pos(1));
    P_vi=Pxe_vi(pos(2),pos(1));
    maxP=max([P_se P_ve P_vi]);
    if P_se==maxP && i<=50
    count_se=count_se+1;
    elseif P_ve==maxP && i>=50 && i<=100
    count_ve=count_ve+1;
    elseif P_vi==maxP && i>=100
    count_vi=count_vi+1;
    end
end
%150 是鸢尾花数据集中的总样本数。所以，(count_vi+count_ve+count_se)/150 就是分类器的准确率，
% 即所有样本中被正确分类的样本的比例。
%这个值越接近 1，表示分类器的性能越好
%
ratio=(count_vi+count_ve+count_se)/150


