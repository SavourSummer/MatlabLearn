g=9.81;%Gravity
v0=input('What is the launch speed in  m/s');
th0=input('whatis the  launch angle in degrees');
th0=pi*th0/180;

txmax=(2*v0/g)*sin(th0);
xmax = txmax*v0*cos(th0);

dt=txmax/100;
t=0:dt:txmax;

x=(v0*cos(th0)).*t;
y=(v0*sin(th0)).*t-(g/2).*t.^2;

vx=v0*cos(th0);
vy=v0*sin(th0)-g.*t;
v=sqrt(vx.*vx+vy.*vy);
th=(180/pi).*atan2(vy,vx);

tymax=(v0/g)*sin(th0);
xymax=xmax/2;
ymax=(v0/2)*tymax*sin(th0);

disp(['Rang in meter = ',num2str(xmax),','...
    'Duration in seconds =',num2str(txmax)])
disp(' ');
disp(['Maximum altitude in meters = ',num2str(ymax),','...
    'Arrival at this altitude in seconds = ',num2str(tymax)])
plot(x,y,'k',xmax,y(size(t)),'o',xmax/2,ymax,'o')
title(['Projectile flight path:v_0= ',num2str(v0),'m/s' ...
    ',\theta_0= ',num2str(180*th0/pi),'degrees'])
xlabel('x'),ylabel('y')
figure
plot(v,th,'r');
xlabel('V'),ylabel('\theta')

