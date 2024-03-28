clc
clear
n=input('Number of walks:');
nsafe=0;

for i=1:n
    steps=0;
    r=rand;
    if r<0.6
        x=x+1;
    else if r<0.8
            y=y+1;
    else
        y=y-1;
    end
    end
    if x>50
        nsafe=nsafe+1;
    end
end;

prod=100*nsafe/n;
disp(prod);