% %Local Methods for Estimating PageRank Values
% %随机生成数据集设共有500个节点
% nodenum=500;
% Out=cell(nodenum,1);%存放节点指向的节点集合
% for i=1:nodenum
%     num=randperm(nodenum/50,1);
%     Out{i}=randperm(nodenum,num);
% end
% In=cell(nodenum,1);%存放指向节点的节点集合
% for i=1:nodenum
%     temp=Out{i};
%     for j=1:length(temp)
%         In{temp(j)}=[In{temp(j)},i];
%     end
% end
% save Pagedata Out In nodenum
clear;
load Pagedata;
Linknum=0;%link数量
for i=1:length(Out)
    Linknum=Linknum+length(Out{i});
end
%普通pagerank
alpha=0.15;%跳转到随机页面的概率
%构造转移矩阵
transfer=zeros(nodenum);
for i=1:nodenum
    temp=Out{i};
    vec=alpha/nodenum*ones(nodenum,1);
    vec(temp)=vec(temp)+(1-alpha)/length(temp);    
    transfer(:,i)=vec;
end
%随机初始PageRank值
P=zeros(nodenum,1);
P(1)=1;
P1=ones(nodenum,1);%随机生成一个较大的值
iter=1;
while norm(P-P1)>1e-10 && iter<100
    P1=P;
    P=transfer*P;  
    iter=iter+1;
end

%局部PageRank
P2=zeros(nodenum,1);
for i=1:nodenum
    P2(i)= Local_Pagerank( Out,In,i);
end

error=sum(abs(P-P2))/nodenum;
