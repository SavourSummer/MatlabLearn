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
Y=[1;1;1;1;1;1;1;2;2;2;2;2;2;2];%训练样本，含序号和特征变量
code_total =1;%当前节点总数
code_num=1;
node{1,1}=1:size(X,1)-1;%存放节点包含的样本序号
node{1,2}=0;%存放节点的级别，当前根节点，为0级
node{1,3}=code_num;%存放节点编号
node{1,4}=[];%内部节点粗发阿哥节点分支特征，叶节点存放类别标签
node_cur = 1;%当前编号

trainig{1,1}=X;trainig{1,2}=node_cur;%存放可分枝节点包含的样本及对应的类别标签
label{1}=Y;%存放可分枝节点包含的样本对应的类别标签
stacknum=0;%处理到的可分枝节点序号，初始化为0

while stacknum~=size(trainig,1)
    stacknum=stacknum+1;%当前处理到的可分枝节点序号
    level=node{stacknum,2}+1;%当前节点所在级别
    label_cur=label{stacknum};%当前样本对应的类别标签
    FatherI = calEnt(label_cur);%当前样本信息熵
    code_cur=trainig{stacknum,1};%当前节点的训练样本
    node_cur=trainig{stacknum,2};%当前节点的编号

    [N,n]=size(code_cur(2:end,2:end));%获取当前节点样本集的样本数目及可用于分枝的特征变量数
    deltaI=zeros(n,1);%各特征对应信息增益初始值

    for i=1:n
        data=code_cur(2:end,i+1);%获取当前样本集的同一特征
        sta=tabulate(data);%统计该特征的取值情况
        sonI=0;%子节点信息熵初始值
        for j=1:size(sta,1);%对于该特征值的每种取值进行处理
            templabel=label_cur(strcmp(data,sta(j,1)));%获取各种取值对应的类别标签
            sonI=sonI+length(templabel)/N*calEnt(templabel);%计算该特征分枝对应的熵
        end
        deltaI(i)=FatherI-sonI;%计算该特征值分枝对应的信息熵
    end
    [~,pos]=max(deltaI);%找最大信息熵
    node{node_cur,4}=code_cur(1,pos+1);%存放当前节点的分枝特征变量名
    data=code_cur(2:end,pos+1);%获取分枝特征对应的数据
    code_cur(:,pos+1)=[];%从当前数据集中去掉该特征数据，在后续节点不再使用该特征分枝
    sta=tabulate(data);%统计分枝取值情况
    for j=1:size(sta,1);%对分枝特征每种取值进行处理，有几种取值就对应几个子节点
        code_num=code_num+1;%节点数增加
        number=strcmp(data,sta(j,1));%获取当前取值对应的样本序号
        number=[false;number];%增加一行，对应特征变量名所在行
        node{end+1,1}=code_cur(number,1);
        node{end,2}=level;
        node{end,3}=code_num;%增加节点，存放样本序号，级别以及编号
        templabel=label_cur(number(2:end));%新节点样本对应的类别标签
        if length(unique(templabel))==1 %标签只有一种时，为叶节点，存放类别标签
            node{end,4}=templabel(1);
        else            %标签有多种时，存储该节点信息
            number(1)=true;
            trainig{end+1,1}=code_cur(number,:);%存储数据，含特征变量名
            trainig{end,2}=code_num;%存储数据对应的节点编号
            label{end+1}=templabel;%存储数据对应的类别标签
        end
    end
end

function Entroph=calEnt(source)%计算当前序列的信息熵
    Entroph=0;
    sta=tabulate(source);
    [c,k]=size(sta);
    for j=1:c
        if sta(j,k)~=0;
            Entroph=Entroph -sta(j,k)/100 * log2(sta(j,k)/100);
        end
    end

end




