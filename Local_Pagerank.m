function [ value ] = Local_Pagerank( Out,In,id)
%���þֲ���Ϣ����PageRankֵ
Lay=3;
L=cell(Lay,1);
L{1}=id;
for i=2:Lay
    temp=L{i-1};
    S=[];
    for j=1:length(temp)
           S=union(S,In{temp(j)});
    end
    L{i}=S;
end
%����Lay��������û�
T=[];
for i=1:Lay
    T=union(T,L{i});
end
maxT=max(T);
index=zeros(maxT,1);
index(T)=1:length(T);
%ֻ�����ֲ�ͼ������
Localout=cell(length(T),1);
for i=1:length(Localout)
    temp=T(i);
    temps=Out{temp};
    Localout{i}=index(intersect(temps,T));
end
Nodenum=length(Out);
%����ת�ƾ���Ѿֲ�ͼ��������нڵ㿴��һ����ڵ�
alpha=0.15;
nodenum=length(T);
transfer=zeros(nodenum+1);
for i=1:nodenum
    temp=Localout{i};
    vec=alpha/Nodenum*ones(nodenum,1);
    vec(temp)=vec(temp)+(1-alpha)/length(Out{T(i)});    
    transfer(1:end-1,i)=vec;
    transfer(end,i)=1-sum(vec);
end
vec=alpha/Nodenum*ones(nodenum+1,1);
tempss=index(L{Lay});
vec(tempss)=vec(tempss)+(1-alpha)/(Nodenum+length(tempss)-length(T));
vec(end)=1-sum(vec(1:end-1));
transfer(:,end)=vec;
P=zeros(nodenum+1,1);
P(end)=1;
value1=1;
iter=1;
while abs(value1-P(index(id)))>1e-5 && iter<100
value1=P(index(id));
P=transfer*P;
iter=iter+1;
end
value=P(index(id));
end
