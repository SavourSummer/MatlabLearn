clc,clear,close all;
X=[-5 -5;-5 -4;-4 -5;-5 -6;-6 -5;5 5;5 4;4 5;5 6;6 5];
label=[1 1 1 1 1 -1 -1 -1 -1 -1];%类别标签
index1=find(label==1); index2=find(label==-1);
N1=length(index1);     N2=length(index2);%两类样本数；
mu1=mean(X(index1,:));mu2=mean(X(index2,:));

S1=(X(index1,:)--mu1)'*(X(index1,:)--mu1);%内类散聚矩阵
S2=(X(index1,:)--mu1)'*(X(index1,:)--mu1);
Sw=S1+S2;%总类内散聚矩阵；

Sb=(mu1 - mu2)'*(mu1 - mu2);%类间矩阵
W=Sw\(mu1-mu2)';%权矩阵
z1=W'*mu1';   z2=W'*mu2';%分类决策，通过z=w*x将数据转为1维以投影超平面
figure,plot(X(index1,1),X(index1,2),'ro',X(index2,1),X(index2,2),'b*');
z0=(z1+z2)/2;
x1=-6:0.1:6;
x2=-(W(1)*x1-z0)/W(2);%计算分界平面（超平面）的点,w(1)*x1+w(2)*x2+z0=0，w*(x1-x2)=0表示w与超平面正交2
hold on;
plot(x1,x2,'g--');

%判别
x=[3 1]';
plot(x(1),x(2),'rp');
z=W'*x;%转为1维，投影到投影超平面
if z>z0
    result ='属于w1'
else
    result ='属于w2'
end
result = strcat('(',num2str(x'),')',result);
title('Fisher线性判别');
line1='x1';
line2=result;
xlabel({line1;line2});
ylabel('x2');
hold off;
 



