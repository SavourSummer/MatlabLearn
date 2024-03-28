clc;clear;close all;
%利用uigetfile函数交互式选取训练样本图片
fmt={'*.jpg','JPEG image(*.jpg)';'*.*','All Files'};
[FileName,FilePath]=uigetfile(fmt,'选择训练图片','*.jpg','MultiSelect','on');
if ~isequal([FileName,FilePath],[0 0])
    FileFullName=strcat(FilePath,FileName);
else 
    return;
end
N=length(FileFullName);
n=16;
Image=zeros(50);
training=zeros(1,n);
labeltrain=[];
for j=1:N
    Image=rgb2gray(imread(FileFullName{j}));
    Image=255-Image;                        %图像反色
    Image=imbinarize(Image,0.2);              %图像二值化
    [y,x]=find(Image==1);                       %获取图像中目标位置
    BWI=Image(min(y):max(y),min(x):max(x)); %获取外接矩形截取数字区域
    BWI=imresize(BWI,[n,n]);                %归一化
    for i=1:n
        pos=find(BWI(i,:));
        if pos
            width=max(pos)-min(pos)+1;
            training(j,i)=width;            %获取每一行宽度作为训练样本
        else
            training(j,i)=0;
        end
    end
    [pathstr,namestr]=fileparts(FileName{j});
    labeltrain=[labeltrain;str2num(namestr(1))];%文件名的第一字符1即为数字类别
end


%训练贝叶斯分类器
ObjBayes=fitcnb(training,labeltrain);

%对未知类别的数据进行决策分类
group = predict(ObjBayes,training);
ratio1=sum(group==labeltrain)/N

%打开测试样本
fmt={'*.jpg','JPEG image(*.jpg)';'*.*','All Files'};
[FileName,FilePath]=uigetfile(fmt,'选择测试图片','*.jpg','MultiSelect','on');
if ~isequal([FileName,FilePath],[0 0])
    FileFullName=strcat(FilePath,FileName);
else 
    return;
end
N=length(FileFullName);
Image=zeros(50);
testing=zeros(1,n);
labeltest=[];
for j=1:N
    Image=rgb2gray(imread(FileFullName{j}));
    Image=255-Image;                        %图像反色
    Image=imbinarize(Image,0.2);              %图像二值化
    [y,x]=find(Image==1);                       %获取图像中目标位置
    BWI=Image(min(y):max(y),min(x):max(x)); %获取外接矩形截取数字区域
    BWI=imresize(BWI,[n,n]);                %归一化
    for i=1:n
        pos=find(BWI(i,:));
        if pos
            width=max(pos)-min(pos)+1;
            testing(j,i)=width;            %获取每一行宽度作为训练样本
        else
            testing(j,i)=0;
        end
    end
    [pathstr,namestr,ext]=fileparts(FileName{j})
    labeltest=[labeltest;str2num(namestr(1))];
end

group=predict(ObjBayes,testing);
ratio2=sum(group==labeltest)/N

