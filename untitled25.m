clc
clear
G=zpk([],[0 -1 -10],[10])
%G=zpk([],[0 -1 -100],[100])
[num,den]=zp2tf([],[0 -1 -10],[285])
G2=tf([0.365 1],[0.027 1])
sys=tf(num,den,'inputdelay',0.1)
sys2=sys*G2
w=logspace(-2,2);
[mag,pha,wcg,wcp]=margin(sys)
margin(sys),grid on