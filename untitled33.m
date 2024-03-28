clc;
clear;
training=[0 0;2 0;2 2;0 2;4 4;6 4;6 6;4 6];
[N,n]=size(training);
species={'one';'one';'one';'one';'two';'two';'two';'two'};

sta=tabulate(species);
[c,k]=size(sta);
priorp=zeros(c,1);
for i=1:c
    priorp(i)=cell2mat(sta(i,k))/100
end

cpmean=zeros(c,n);cpcov=zeros(n,n,c);
for i=1:c
    cpmean(i,:)=mean(training(strcmp(char(sta(i,1)),species),:))
    cpcov(:,:,i)=cov(training(strcmp(char(sta(i,1)),species),:))...
        *(N*priorp(i)-1)/(N*priorp(i))
end

X=[4 4];
postp=zeros(c,1);
for i=1:c
postp(i)=priorp(i)*exp(-(X-cpmean(i,:))/(cpcov(:,:,i))...
        * (X-cpmean(i,:))'/2)/((2*pi)^(n/2)*det(cpcov(:,:,i)))
end
[~,i]=max(postp(:))
max(postp(:))