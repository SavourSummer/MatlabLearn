clear
clc
syms g t k y

y=(g/k)*t-(g/(k^2))*(1.-exp(-k*t));
v=diff(y,t);
a=diff(v,t);
v,a
a2=g-k*v
a2=simplify(a2)
t(1)=0.;
dt=.01
t=0:dt:5;
k=0.2;g=9.81;
y=(g/k)*t-(g/(k^2))*(1.-exp(-k*t));
plot(t,y,'ro')
