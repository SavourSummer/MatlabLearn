clc
clear
f=zeros(1,100);
x=40;

for i=1:1000
    r=rand;
    if r >=0.5
        x=x+1;
    else
        x=x-1;
    end;
    if x~=0|x~=100
        f(x)=f(x)+1;
    end
end