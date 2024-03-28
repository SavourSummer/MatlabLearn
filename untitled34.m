clc,clear,close all;
training=[0 0 0;1 0 0;1 0 1;1 1 0;0 0 1;0 1 1;0 1 0;1 1 1];
Y=[1;1;1;1;-1;-1;-1;-1];
Mdl=fitcdiscr(training,Y)
coeff=Mdl.Coeffs(1,2);
W=coeff.Linear;
pos=Y<0;
scatter3(training(pos>0,1),training(pos>0,2),training(pos>0,3),'r*');    %绘制第二类的点
hold on
scatter3(training(~pos,1),training(~pos,2),training(~pos,3),'bo');        %绘制第一类的点
[x1,x2]=meshgrid(0:0.1:1,0:0.1:1);
x3=-(W(1)*x1+W(2)*x2+coeff.Const)/W(3);
mesh(x1,x2,x3);
X=[0 0.6 0.9];
scatter3(X(:,1),X(:,2),X(:,3),'g>');
[label,score,cost]=predict(Mdl,X);
xlabel('x1'),ylabel('x2'),zlabel('x3');
hold off