clc,clear,close all;
X=[-5 -5;-5 -4;-4 -5;-5 -6;-6 -5;5 5;5 4;4 5;5 6;6 5;-5 5;-5 4;-4 5;-5 6;-6 5];
label=[1;1;1;1;1;2;2;2;2;2;3;3;3;3;3];

sta=tabulate(label);%获取类别标记，tabulate:计算频率
[c,k]=size(sta);[N,n]=size(X);%获取矩阵大小
Z=ones(N,n+1);Z(:,1:n)=X;%矩阵增广化
figure,hold on;
axis([-10 10 -10 10]);

pointtype=['o';'*';'+'];%不同类样本采用不同标志
linetype=['r--';'g-.';'b: '];%不同线性分类面采用不同标志
x=[-2;-2]; plot(x(1),x(2),'k>');%待测样本
xsign= zeros(c,1);num=1;

for i=1:c
    templabel=-1*ones(N,1);%非i类样本编号为-1
    index=find(label==sta(i,1));%第i类样本的索引
    plot(X(index,1),X(index,2),pointtype(num));
    templabel(index,1)=1;%第i类样本编号为1
    A=regress(templabel,Z);%用最小二乘法求权向量
    x1=-10:0.1:10;
    x2=-(A(1)*x1+A(3))/(A(2));
    plot(x1,x2,linetype(num,:))%绘制分界线
    num=num+1;
    if num==4
        num=1;%预定标记用完从第一个再开始
    end
    xsign(i)=A'*[x;1];%计算待测样本对应判别函数
end
result=strcat('[',num2str(x'),']','属于第',num2str(find(xsign>0)),'类');
% title('一对多化多类为两类');
line1='x1';
line2=result;
xlabel({line1;line2});
ylabel('x2');
legend('待测样本','ω1','ω1/非ω1','ω2','ω2/非ω2','ω3','ω3/非ω3');
box on
hold off;

