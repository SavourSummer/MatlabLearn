clc,clear,close all;
X=[-5 -5;-5 -4;-4 -5;-5 -6;-6 -5;5 5;5 4;4 5;5 6;6 5;-5 5;-5 4;-4 5;-5 6;-6 5];
label=[1;1;1;1;1;2;2;2;2;2;3;3;3;3;3];

sta = tabulate(label);%获取类别数，样本数，维数
[c,~]=size(sta);
[N,n]=size(X);

Z=ones(N,n+1); %增广
Z(:,1:n)=X; 

A=zeros(c,n+1);%初始化
rho=1;
flag=1;

while flag
    flag=0;
    for i=1:N
        for j=1:c
            g(j)=A(j,:)*Z(i,:)';%对每个样本计算c个判别函数值
        end
        [maxg,pos]=max(g);%最大值及其对应类别
        if pos~=label(i)%与真实类别不匹配则修正权向量
            A(label(i),:)=A(label(i),:)+rho*Z(i,:);
            A(pos,:)=A(pos,:)-rho*Z(i,:);
            flag=1;
        end
    end
end
figure,hold on;
axis([-10 10 -10 10]);
x=[-2;-2];                    
plot(x(1),x(2),'k>');%绘制待测样本


pointtype=['o','*','+']; 
xsign=zeros(c,1);

for i=1:c
    index=find(label==sta(i,1));
    plot(X(index,1),X(index,2),pointtype(i)); %绘制样本点
    xsign(i)=A(i,:)*[x;1];%计算待测样本对应判别函数值
end


linetype=['r--';'g-.';'b: ']; 
num=1;
for i=1:c-1
    for j=i+1:c
        x1=-10:0.1:10;
        x2=-((A(i,1)-A(j,1))*x1+A(i,3)-A(j,3))/(A(i,2)-A(j,2));%计算分界上的点
         plot(x1,x2,linetype(num,:));
         num=num+1;
         if num==4
             num=1;
         end
    end
end
[~,pos]=max(xsign);
result=strcat('(',num2str(x'),')','属于第',num2str(pos),'类');%归为判别函数值最大的类
title('逐步修正设计多类线性判别函数');
line1='x1';line2=result;
xlabel({line1;line2});
ylabel('x2');
legend('待测样本','ω1','ω2','ω3','g1=g2','g1=g3','g2=g3');
hold off;
