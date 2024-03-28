clc,clear,close all;
% 这段MATLAB代码的目的是加载一个名为hospital的数据集，然后根据性别分组拟合体重数据的正态分布，并绘制出两个性别的概率密度函数（PDF）。
% 
% 下面是这段代码的详细解释：
% 
% clc,clear,close all;：清除命令窗口，清除工作空间变量，关闭所有图形窗口。
% load hospital：加载名为hospital的数据集。
% x=hospital.Weight;：将hospital数据集中的Weight列赋值给变量x。
% gender=hospital.Sex;：将hospital数据集中的Sex列赋值给变量gender。
% [pdca,gn,gl]=fitdist(x,'Normal','By',gender);：按性别分组，对每组的体重数据拟合正态分布。
% female=pdca{1}; male=pdca{2};：将拟合结果分别赋值给female和male。
% x_values=50:250;：创建一个从50到250的向量，用于计算概率密度函数。
% femalepdf=pdf(female,x_values); malepdf=pdf(male,x_values);：计算在x_values上的概率密度函数。
% figure：创建一个新的图形窗口。
% plot(x_values,femalepdf,'Color','r','LineWidth',2)：绘制女性的概率密度函数，线条颜色为红色，线宽为2。
% hold on：保持当前图形，以便在同一图形上添加更多的绘图。
% plot(x_values,malepdf,'Color','b','LineStyle','--','LineWidth',2);：在同一图形上绘制男性的概率密度函数，线条颜色为蓝色，线型为虚线，线宽为2。
% xlabel('x'),ylabel('p(x)');：设置x轴和y轴的标签。
% legend(gn,'Location','NorthEast')：添加图例，位置在图形的东北角。
% hold off：取消保持当前图形。
% 这段代码的结果是一个图形，显示了男性和女性体重数据的正态分布的概率密度函数。
% 





load hospital
x=hospital.Weight;%获取身体数据
gender=hospital.Sex;%获取性别数据，并且分组
[pdca,gn,gl]=fitdist(x,'Normal','By',gender);%用正态分布对两组数据进行拟合,’By’参数来指定一个分组变量，然后对每个组的数据分别拟合概率分布
female=pdca{1};
male=pdca{2};
x_values=50:250;%创建一个从50到250的向量，用于计算概率密度函数
femalepdf=pdf(female,x_values);%计算在x_values上的概率密度函数。
malepdf=pdf(male,x_values);
plot(x_values,femalepdf,'Color','r','LineWidth',2);
hold on
plot(x_values,malepdf,'Color','b','LineStyle','--','LineWidth',2);
xlabel('x'),ylabel('p(x)');
legend(gn,'Location','northeast')%添加图例，位置在图形的东北角。
hold off


