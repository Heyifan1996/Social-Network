load link;
A=link(1:5000,:);
maxnodeid=max(max(A));
L=zeros(maxnodeid);
for i=1:length(A)
    L(A(i,1),A(i,2))=1;
    L(A(i,2),A(i,1))=1;
end
Neigh=cell(maxnodeid,1);
for i=1:maxnodeid
    Neigh{i}=find(L(i,:)>0);
end
maxiter=100;
NN1=zeros(maxiter,1);
for iter=1:maxiter
%整体策略是去除掉non-cross-cuting 边
sample=[1];
samplesize=100;
tempu=1;
while length(sample)<samplesize
    tic;
while length(Neigh{tempu})>=1
    temp1=Neigh{tempu};%u的邻居节点
    tempv=temp1(randperm(length(temp1),1));%随机选择一个进行查询
    temp2=Neigh{tempv};%v的邻居节点
    unode=intersect(temp1,temp2);
    if  condition( temp1,temp2,unode,Neigh)%判断是否替换边
        Neigh{tempu}=setdiff(temp1,tempv);%减去non-cross-cuting 边
        continue
    elseif length(temp2)==3
        if  rand(1,1)<0.5 %判断是否替换边,换了没损失
            S=setdiff(temp2,tempu);
            Neigh{tempu}=setdiff(temp1,tempv);
            tempv=S(randperm(length(S),1));
            Neigh{tempu}=[Neigh{tempu},tempv];
        else
             S=setdiff(temp2,tempu);
             tempw=S(randperm(length(S),1));
              Neigh{tempu}=[Neigh{tempu},tempw];
              T=[tempw,tempv];
              tempu=T(randperm(2,1));
              break            
        end
    end
    if rand(1,1)<0.5
            tempu=tempv;
            break
        else
            continue
    end   
end
sample=[sample,tempu];
toc;
end

%评判爬取结果
A=link(1:5000,:);
maxnodeid=max(max(A));
L=zeros(maxnodeid);
for i=1:length(A)
    L(A(i,1),A(i,2))=1;
    L(A(i,2),A(i,1))=1;
end
Neigh=cell(maxnodeid,1);
for i=1:maxnodeid
    Neigh{i}=find(L(i,:)>0);
end
Net1=[];
for i=1:length(sample)
    temp=Neigh{sample(i)};
    Net1=union(Net1,temp);
end
NN1(iter)=length(Net1);
end

Cov1=mean(NN1);%1491

%随机游走比较
A=link(1:5000,:);
maxnodeid=max(max(A));
L=zeros(maxnodeid);
for i=1:length(A)
    L(A(i,1),A(i,2))=1;
    L(A(i,2),A(i,1))=1;
end
Neigh=cell(maxnodeid,1);
for i=1:maxnodeid
    Neigh{i}=find(L(i,:)>0);
end
NN2=zeros(maxiter,1);
for iter=1:maxiter
sample1=1;
tempu=1;
for i=1:100
    temp1=Neigh{tempu};
    tempv=temp1(randperm(length(temp1),1));
    sample1=[sample1,tempv];
    tempu=tempv;   
end
Net2=[];
for i=1:length(sample1)
    temp=Neigh{sample1(i)};
    Net2=union(Net2,temp);
end
NN2(iter)=length(Net2);
end
Cov2=mean(NN2);%1446
