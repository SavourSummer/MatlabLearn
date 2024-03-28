clear
clc
a=eye(1000);
%A=a^2
s=sparse(1:1000,1:1000,1,1000,1000);
S=s^2
full(S)