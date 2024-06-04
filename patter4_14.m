clc;clear;close all;
% 利用uigetfile函数交互式选取训练样本图片

%当用户使用uigetfile函数打开文件选择对话框时，
% fmt变量提供了文件类型的过滤选项。
% 用户可以选择JPEG image(*.jpg)来过滤并只显示JPEG图像文件，
% 或者选择All Files(*.*)来显示所有文件类型。
%
fmt={'*jpg','JPEG image(*.jpg'; % 第一行定义了JPEG图像文件的过滤器
    '*.*','All Files(*.*)'% 第二行定义了所有文件类型的过滤器
    };
[FileName,FilePath]=uigetfile(fmt,'选择训练图片','*.jpg','MultiSelect','on');

if ~isequal([FileName,FilePath],[0 0])
    FileFullName=strcat(FilePath,FileName);
else 
    return;
end

N=length(FileFullName); % 获取选取的文件数量
n=16;% 设置图像处理后的大小
Image=zeros(50); % 初始化图像矩阵
training=zeros(1,n); % 初始化训练数据矩阵
labeltrain=[]; % 初始化训练标签数组

for j=1:N
     Image=rgb2gray(imread(FileFullName{j})); % 读取图像并转换为灰度图
     Image=255-Image; % 反转图像颜色
    Image=imbinarize(Image,0.2); % 二值化处理
    [y,x]=find(Image==1); % 找到二值化图像中的白色像素坐标
     BWI=Image(min(y):max(y),min(x):max(x)); % 裁剪图像，只保留包含白色像素的区域
    BWI=imresize(BWI,[n,n]); % 将裁剪后的图像调整为n*n大小
    for i=1:n % 遍历每一行
        pos=find(BWI(i,:)); % 找到当前行中的白色像素坐标
        if pos
            width=max(pos)-min(pos)+1; % 计算白色像素区域的宽度
            training(j,i)=width; % 将宽度值存入训练数据矩阵
        else
            training(j,i)=0; % 如果当前行没有白色像素，则宽度为0
        end
    end
    [pathstr,namestr,ext]=fileparts(FileName{j}); % 分解文件名
    labeltrain=[labeltrain;str2num(namestr(1))]; % 将文件名的第一个字符转换为数字，并作为标签存入数组
end

Mdl=fitcecoc(training,labeltrain); % 使用训练数据和标签训练多类分类器
label=predict(Mdl,training); % 使用训练好的分类器对训练数据进行预测
ratio1=sum(label==labeltrain)/N % 计算分类器在训练数据上的准确率


%---- 下面的代码与上面类似，但用于测试图片
fmt={'*.jpg','JPEG image(*.jpg)';'*.*','All Files(*.*)'};
[FileName,FilePath]=uigetfile(fmt,'选择测试图片','*.jpg','MultiSelect','on');
if ~isequal([FileName,FilePath],[0,0])
    FileFullName=strcat(FilePath,FileName);
else 
    return;
end 
N=length(FileFullName); % 获取选取的文件数量

Image=zeros(50); % 初始化图像矩阵
testing=zeros(1,n); % 初始化测试数据矩阵
labeltest=[]; % 初始化测试标签数组

for j=1:N % 遍历所有选取的文件
    Image=rgb2gray(imread(FileFullName{j})); % 读取图像并转换为灰度图
    Image=255-Image; % 反转图像颜色
    Image=imbinarize(Image,0.2); % 二值化处理
    [y,x]=find(Image==1); % 找到二值化图像中的白色像素坐标
    BWI=Image(min(y):max(y),min(x):max(x)); % 裁剪图像，只保留包含白色像素的区域
    BWI=imresize(BWI,[n,n]); % 将裁剪后的图像调整为n*n大小
    for i=1:n % 遍历每一行
        pos=find(BWI(i,:)); % 找到当前行中的白色像素坐标
        if pos
            width=max(pos)-min(pos)+1; % 计算白色像素区域的宽度
            testing(j,i)=width; % 将宽度值存入测试数据矩阵
        else
            testing(j,i)=0; % 如果当前行没有白色像素，则宽度为0
        end
    end

     [pathstr,namestr,ext]=fileparts(FileName{j}); % 分解文件名
    labeltest=[labeltest;str2num(namestr(1))]; % 将文件名的第一个字符转换为数字，并作为标签存入数组
end
%----


label=predict(Mdl,testing); % 使用训练好的分类器对测试数据进行预测
ratio2=sum(label==labeltest)/N % 计算分类器在测试数据上的准确率