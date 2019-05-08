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
%���������ȥ����non-cross-cuting ��
sample=[1];
samplesize=100;
tempu=1;
while length(sample)<samplesize
    tic;
while length(Neigh{tempu})>=1
    temp1=Neigh{tempu};%u���ھӽڵ�
    tempv=temp1(randperm(length(temp1),1));%���ѡ��һ�����в�ѯ
    temp2=Neigh{tempv};%v���ھӽڵ�
    unode=intersect(temp1,temp2);
    if  condition( temp1,temp2,unode,Neigh)%�ж��Ƿ��滻��
        Neigh{tempu}=setdiff(temp1,tempv);%��ȥnon-cross-cuting ��
        continue
    elseif length(temp2)==3
        if  rand(1,1)<0.5 %�ж��Ƿ��滻��,����û��ʧ
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

%������ȡ���
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

%������߱Ƚ�
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
