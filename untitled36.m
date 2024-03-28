clc,clear,close all;
% X=[34 3 1 2;28 1 2 2;42 2 3 2;45 3 2 1;50 2 1 1;61 2 1 1;65 1 3 2;36 3 2 1;31 1 3 2;27 2 1 2;44 2 3 1;43 2 2 1;61 1 3 1;66 1 3 1];
X=["序号" "年龄" "体重" "饮食偏好" "父辈血压";"1" "青年" "超重" "油腻" "高";...
    "2" "青年" "正常" "均衡" "高";"3" "中年" "偏重" "清淡" "高";...
    "4" "中年" "超重" "均衡" "正常";"5" "中年" "偏重" "油腻" "正常";...
    "6"  "老年" "偏重" "油腻" "正常";"7" "老年" "正常" "清淡" "高";...
    "8" "青年" "超重" "均衡" "正常";"9" "青年" "正常" "清淡" "高";...
    "10" "青年" "偏重" "油腻" "高";"11" "中年" "偏重" "清淡" "正常";...
    "12" "中年" "偏重" "均衡" "正常";"13" "老年" "正常" "清淡" "正常";...
    "14" "老年" "正常" "清淡" "正常"];
Y=[1;1;1;1;1;1;1;2;2;2;2;2;2;2];
code_num=1;
node{1,1}=1:size(X,1)-1;
node{1,2}=0;
node{1,3}=code_num;
node{1,4}=[];
node_cur=1;
training{1,1}=X;
training{1,2}=node_cur;
label{1}=Y;
stacknum=0;
while stacknum~=size(training,1)
    stacknum=stacknum+1;
    level=node{stacknum,2}+1;    
    label_cur=label{stacknum};
    FatherI=calEnt(label_cur);
    code_cur=training{stacknum,1};
    node_cur=training{stacknum,2};
    [N,n]=size(code_cur(2:end,2:end));
    deltaI=zeros(n,1);
    for i=1:n
        data=code_cur(2:end,i+1);
        sta=tabulate(data);
        sonI=0;
        for j=1:size(sta,1)
            templabel=label_cur(strcmp(data,sta(j,1)));
            sonI=sonI+length(templabel)/N*calEnt(templabel);
        end
        deltaI(i)=FatherI-sonI;
    end
    [~,pos]=max(deltaI);
    node{node_cur,4}=code_cur(1,pos+1);
    data=code_cur(2:end,pos+1);
    code_cur(:,pos+1)=[];
    sta=tabulate(data);
  
    for j=1:size(sta,1)
        code_num=code_num+1;
        number=strcmp(data,sta(j,1));
        number=[false;number];
        node{end+1,1}=code_cur(number,1);
        node{end,2}=level;
        node{end,3}=code_num;
        templabel=label_cur(number(2:end));
        if length(unique(templabel))==1
            node{end,4}=templabel(1);
        else
            number(1)=true;
            training{end+1,1}=code_cur(number,:);
            training{end,2}=code_num;
            label{end+1}=templabel;            
        end        
    end
end

function Entroph=calEnt(source)   
    Entroph=0;   
    sta=tabulate(source);
    [c,k]=size(sta);
    for j=1:c
        if sta(j,k)~=0
            Entroph=Entroph-sta(j,k)/100*log2(sta(j,k)/100);
        end
    end
end