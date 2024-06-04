clc,clear,close all;
X=[-5 -5;-5 -4;-4 -5;-5 -6;-6 -5;5 5;5 4;4 5;5 6;6 5;-5 5;-5 4;-4 5;-5 6;-6 5];
label=[1;1;1;1;1;2;2;2;2;2;3;3;3;3;3];
sta=tabulate(label);
[c,k]=size(sta); 
[N,n]=size(X);
Z=ones(N,n+1);       
Z(:,1:n)=X; 
num=1;
figure,hold on;
axis([-10 10 -10 10]);
pointtype=['o','*','+']; 
for i=1:c%绘制各类样本点
    index=find(label==sta(i,1));
    plot(X(index,1),X(index,2),pointtype(i)); 
end

x=[-2;-2];                    
plot(x(1),x(2),'k>');
linetype=['--';'-.';'k:']; 
xsign=zeros(c,c);         
for i=1:c-1
    for j=i+1:c
        indexi=find(label==sta(i,1));
        indexj=find(label==sta(j,1));
        training=[Z(indexi,:);Z(indexj,:)];%wi和wj的数据
        templabel=[ones(length(indexi),1);-1*ones(length(indexj),1)];%类别标号向量
        A=regress(templabel,training);
        x1=-10:0.1:10;
        x2=-(A(1)*x1+A(3))/(A(2));
        plot(x1,x2,linetype(num,:));%绘制分界线
        num=num+1;
        if num==4
            num=1;
        end
        xsign(i,j)=A'*[x;1];
        xsign(j,i)=-xsign(i,j);
    end
end
for i=1:c-1
    if min(xsign(i,:))>=0
        result=strcat('[',num2str(x'),']','属于第',num2str(i),'类');
    end
end
% title('一对一化多类为两类');
line1='x1';
line2=result;
xlabel({line1;line2});
ylabel('x2');
legend('ω1','ω2','ω3','待测样本','ω1/ω2','ω1/ω3','ω2/ω3');
box on
hold off;
