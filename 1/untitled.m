K= 0.05;
F=10;
a=0;
b=100;
time=a;
T=25;
load splat
dt=input('dt：');
opint = input('out interval (minutes):');
if opint/dt ~= fix(opint/dt)
    sound(y,Fs);
    disp('output interval is not a multiple of dt ')
end

clc
format bank
disp('Time Temperature');
disp([time T])

for time = a+dt:dt:b
    T=T-K*dt*(T-F);
    if abs(rem(time,opint))<1e-6
        disp([time T])
    end
end
