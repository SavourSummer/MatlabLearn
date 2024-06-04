clc,clear,close all;
X=[0 0 0;1 0 0;1 0 1;1 1 0;0 0 1;0 1 1;0 1 0;1 1 1];
label=[1 1 1 1 -1 -1 -1 -1];

[N,n]=size(X);%样本数以及维数
Z=X;  Z(:,n+1)=1;%样本增广
pos=label<0; 
Z(pos,:)=0-Z(pos,:);%样本规范化

A=zeros(n+1,1);rho= 1;%权向量和增量初始化
flag=1;%梯度下降算法求解权向量
while flag
    flag=0;
    for i=1:N
        g=A'*Z(i,:)';
        if g<=0
            A=A+rho*Z(i,:)';
            flag=1;
        end
    end
end

pos=label<0;
scatter3(X(pos>0,1),X(pos>0,2),X(pos>0,3),'r*');%绘制第二类样本
hold on
scatter3(X(~pos,1),X(~pos,2),X(~pos,3),'g*');
[x1,x2]=meshgrid(0:0.01:1,0:0.01:1);
x3=-(A(1)*x1+A(2)*x2+A(4))/A(3);
mesh(x1,x2,x3),title('训练样本及分界面');
xlabel('x1'),ylabel('x2'),zlabel('x3');
hold off 