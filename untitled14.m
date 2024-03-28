K = 0.05;
F=10;
time = 0:100;
T=zeros(1,101);
T(1)=25;

for i = 1:100
    T(i+1) = T(i)-K*(T(i)-F);
end
disp([ time(1:5:101)' T(1:5:101)'])
plot(time,T),grid on