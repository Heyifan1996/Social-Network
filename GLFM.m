% load Socialdata;
% Set=unique(cora(:,1));
% m=max(Set);
% Index=zeros(m,1);
% Index(Set)=1:length(Set);%��������ת�����ױ��Ϊ1~2708
% cora(:,1)=Index(cora(:,1));
% link(:,1)=Index(link(:,1));
% link(:,2)=Index(link(:,2));
% save Socialdata cora link
load Socialdata;
nodenum=max(cora(:,1));
Xmat=cora(:,2:end);
A=zeros(nodenum);%����ת��Ϊ��ϵ����
for i=1:length(link)
    A(link(i,1),link(i,2))=1;
end
%��ʼ������
beta=2;
gama=2;
tao=1e6;
D=20;
T=5;
%�ѽڵ������Ĺ�ϵ��Ϊ0��
for i=1:nodenum
    A(i,i)=0;
end
Z=A>0; 
%ͨ��pca��ά
[~,X]=pca(Xmat);
%��ʼ��U,V
U=X(:,1:D);
V=X(:,1:D);
clear X;
Sigma=eye(nodenum)/beta;
l_q=eye(D);
muu=0;


for t=1:T
    tic;
    %����U
    for i=1:nodenum
        S1=zeros(1,nodenum);
        S2=zeros(nodenum,1);
        index1=find(Z(i,:)==1);
        index2=find(Z(:,i)==1);
        X1=U(i,:)*(U(index1,:)+V(index1,:))'+muu;
        S1(index1)=exp(X1/2)./(exp(-X1/2)+exp(X1/2));
        X2=U(index2,:)*(U(i,:)+V(i,:))'+muu;
        S2(index2)=exp(X2/2)./(exp(-X2/2)+exp(X2/2));
        Gradient=(A(i,:)+A(:,i)'-S1-S2'-Sigma(i,:))*U+(A(i,:)-S1)*V;
        U1=U(index1,:)+V(index1,:);
        U2=U(index2,:);
        H=(U1'*U1+U2'*U2)/4+Sigma(i,i)*l_q;
        invH=H\l_q;
        invH=(invH+invH')/2;
         U(i,:) = U(i,:) + Gradient * invH; 
    end
    %����V
    for i=1:nodenum
        S=zeros(nodenum,1);
        index=find(Z(:,i)==1);
        X=U(index,:)*(U(i,:)+V(i,:))'+muu;
        S(index)=exp(X/2)./(exp(-X/2)+exp(X/2));
        Gradient=(A(:,i)'-S')*U-Sigma(i,:)*V;
        U1=U(index,:);
        G=(U1'*U1)/4+Sigma(i,i)*l_q;
        invG=G\l_q;
        invG=(invG+invG')/2;
        V(i,:)=V(i,:)+Gradient*invG;   
    end
    %����muu
    X=U*(U+V)'+muu;
    S=exp(X/2)./(exp(-X/2)+exp(X/2));
    muu=muu+4/(sum(sum(Z))+4*tao)*(sum(sum(A-Z.*S))-tao*muu);
    toc;
end
%����Kmeans��ѵ������U����
K=2;
% center1=U(1,:);%��һ����������
% %ѡ������һ����Զ����Ϊ�ڶ�����������
% Dist1=zeros(nodenum,1);
% for i=1:nodenum
%     Dist1(i)=norm(center1-U(i,:));
% end
% [~,index]=max(Dist1);
% center2=U(index,:);
center2=randn(1,D);%��ʼ���ĵ�
center1=randn(1,D);
iter=0;
for iter=1:100
Dist1=zeros(nodenum,1);
for i=1:nodenum
    Dist1(i)=norm(center1-U(i,:));
end
Dist2=zeros(nodenum,1);
for i=1:nodenum
    Dist2(i)=norm(center2-U(i,:));
end
Compare=Dist1-Dist2;
index1set=find(Compare<=0);%��һ�ؽڵ�
index2set=find(Compare>0);%�ڶ��ؽڵ�
center1=mean(U(index1set,:));
center2=mean(U(index2set,:));
end





