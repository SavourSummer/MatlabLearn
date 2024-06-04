clc,clear,close all;
X=[-5 -5;-5 -4;-4 -5;-5 -6;-6 -5;5 5;5 4;4 5;5 6;6 5;-5 5;-5 4;-4 5;-5 6;-6 5];
Y=[1;1;1;1;1;2;2;2;2;2;3;3;3;3;3];

Mdl1=fitcecoc(X,Y);%采用一对一划分，使用SVM分类器创建ECOC模型
Mdl2=fitcecoc(X,Y,'Coding','onevsall');%采用一对多划分，使用SVM分类器创建ECOC模型

[x1Grid,x2Grid]=meshgrid(-10:0.01:10,-10:0.01:10); % 创建一个网格，用于可视化
xGrid=[x1Grid(:),x2Grid(:)]; % 将网格转换为用于预测的列向量形式
subplot(121), gscatter(X(:,1),X(:,2),Y,'rgb','o*+'); % 在子图1中绘制原始数据点
hold on % 保持当前图形，用于添加新的图形元素
[label1,negloss1,scores1]=predict(Mdl1,xGrid); % 使用第一个分类器进行预测
% 绘制决策边界
contour(x1Grid,x2Grid,reshape(scores1(:,1),size(x1Grid)),[0 0],'k--'); 
contour(x1Grid,x2Grid,reshape(scores1(:,2),size(x1Grid)),[0 0],'k-.');
contour(x1Grid,x2Grid,reshape(scores1(:,3),size(x1Grid)),[0 0],'k-');
% title('一对一划分'); % 子图1的标题
hold off % 释放图形保持状态
subplot(122), gscatter(X(:,1),X(:,2),Y,'rgb','o*+'); % 在子图2中绘制原始数据点
hold on % 保持当前图形
[label2,negloss2,scores2]=predict(Mdl2,xGrid); % 使用第二个分类器进行预测
% 绘制决策边界
contour(x1Grid,x2Grid,reshape(scores2(:,1),size(x1Grid)),[0 0],'k--');
contour(x1Grid,x2Grid,reshape(scores2(:,2),size(x1Grid)),[0 0],'k-.');
contour(x1Grid,x2Grid,reshape(scores2(:,3),size(x1Grid)),[0 0],'k-');
% title('一对多划分'); % 子图2的标题
hold off % 释放图形保持状态