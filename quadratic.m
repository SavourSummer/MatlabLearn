function x=quadratic(a,b,c)
if a==0&b==0&c==0
    disp(' ')
    disp('Solution indeterminate')
elseif a==0 & b==0
    disp(' ')
    disp('There is no solution')
elseif a==0
    disp(' ')
    disp('Only one root : equation is linear')
    disp(' x ')
    x1=-c/b;
    x2=NaN;
elseif b^2 <4*a*c
    disp(' ')
    disp('x1,x2 are complex root')
    x1 = (-b + sqrt(b^2 - 4*a*c))/(2*a);
    x2 = (-b - sqrt(b^2 - 4*a*c))/(2*a);
elseif b^2 ==4*a*c


    x1 = -b/(x*a);
    x2 = x1;

    disp('equal root')
    disp('x1 x2 ')
else
    x1 = (-b + sqrt(b^2 - 4*a*c))/(2*a);
    x2 = (-b - sqrt(b^2 - 4*a*c))/(2*a);
    disp('x1 x2 ')
end
if a==0&b==0&c==0
elseif a==0 & b==0
else
    disp([x1 x2]);
end
end