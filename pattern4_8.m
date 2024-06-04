clc,clear,close all;
X1=[0 0 0;1 0 0;1 0 1;1 1 0;0 0 1;0 1 1;0 1 0;1 1 1];
label1=[1;1;1;1;-1;-1;-1;-1];
[N,n]=size(X1);
Z1=ones(N,n+1);        Z1(:,1:n)=X1;
A=regress(label1,Z1)

X2=[0 0;0 1;1 0;1 1];
label2=[1;1;-1;-1];
regstats(label2,X2)