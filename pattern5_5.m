clc; clear; close all;

load fisheriris;

rng(1)%随机数生成器的种子，以便实验具有可重复性。

N = size(meas, 1);%数据集中样本的总数。
testIdx = randsample(N, 3);%随机选择3个样本作为测试集。
trainIdx = ~ismember(1:N, testIdx);%创建一个逻辑索引数组，用于选择不在测试集中的样本作为训练集。

testing = meas(testIdx, 3:4);%测试集中提取花瓣的长度和宽度。

training = meas(trainIdx, 3:4);%训练集中提取花瓣的长度和宽度。

labeltrain = species(trainIdx, :);%获取训练集的标签。


Mdl = KDTreeSearcher(training);%使用训练数据创建一个k-d树搜索器。

[Idx1, D1] = knnsearch(Mdl, testing);%测试样本的最近邻点。

testresult = labeltrain(Idx1);%根据最近邻点的标签预测测试样本的类别。

radius = 0.2;%设置搜索半径。

[Idx2, D2] = rangesearch(Mdl, testing, radius);%找到在指定半径内的所有邻居。


gscatter(training(:, 1), training(:, 2), labeltrain, 'rgb', '+.o', 3);%使用不同的颜色和标记类型绘制训练样本。
hold on;


plot(testing(:,1),testing(:,2),'kx','MarkerSize',6,'LineWidth',2);   %'kx' 指定用黑色的 x 标记这些点
plot(training(Idx1,1),training(Idx1,2),'m*'); %training(Idx1,1) 和 training(Idx1,2) 分别表示最近邻点的花瓣长度和宽度。'm*' 指定用洋红色的星号标记这些点。

for i=1:length(Idx2)
    viscircles(testing(i,:),radius,'color','k','LineWidth',1,'LineStyle','-.'); %个循环为每个测试点绘制一个圆圈，表示搜索半径
end    
legend('setosa','versicolor','virginica','待测样本','最近邻点');
xlabel('花瓣长(cm)'),ylabel('花瓣宽(cm)');
hold off


