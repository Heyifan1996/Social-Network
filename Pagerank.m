% %Local Methods for Estimating PageRank Values
% %����������ݼ��蹲��500���ڵ�
% nodenum=500;
% Out=cell(nodenum,1);%��Žڵ�ָ��Ľڵ㼯��
% for i=1:nodenum
%     num=randperm(nodenum/50,1);
%     Out{i}=randperm(nodenum,num);
% end
% In=cell(nodenum,1);%���ָ��ڵ�Ľڵ㼯��
% for i=1:nodenum
%     temp=Out{i};
%     for j=1:length(temp)
%         In{temp(j)}=[In{temp(j)},i];
%     end
% end
% save Pagedata Out In nodenum
clear;
load Pagedata;
Linknum=0;%link����
for i=1:length(Out)
    Linknum=Linknum+length(Out{i});
end
%��ͨpagerank
alpha=0.15;%��ת�����ҳ��ĸ���
%����ת�ƾ���
transfer=zeros(nodenum);
for i=1:nodenum
    temp=Out{i};
    vec=alpha/nodenum*ones(nodenum,1);
    vec(temp)=vec(temp)+(1-alpha)/length(temp);    
    transfer(:,i)=vec;
end
%�����ʼPageRankֵ
P=zeros(nodenum,1);
P(1)=1;
P1=ones(nodenum,1);%�������һ���ϴ��ֵ
iter=1;
while norm(P-P1)>1e-10 && iter<100
    P1=P;
    P=transfer*P;  
    iter=iter+1;
end

%�ֲ�PageRank
P2=zeros(nodenum,1);
for i=1:nodenum
    P2(i)= Local_Pagerank( Out,In,i);
end

error=sum(abs(P-P2))/nodenum;
