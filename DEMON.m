% load network;
load A;


number=length(unique(A(:,1)));
label=[1:number]';
L=cell(number,1);
for i=1:length(A)
   L{A(i,1)}=cat(2,L{A(i,1)},label(A(i,2))) ;
end


itermax=100;
for i=1:itermax
    label=updata( L );
    L=cell(number,1);
    for i=1:length(A)
        L{A(i,1)}=cat(2,L{A(i,1)},label(A(i,2))) ;
    end
    U=length(unique(label));
    disp(U);
end

U1=unique(label);
T=cell(U,1);
for i=1:U
    T{i}=find(label==U1(i));
end
% local=zeros(number,2);
% for i=1:number
%     local(i,:)=[randperm(10,1),randperm(10,1)];
% end
% save local local;
load local1;
G=cell(U,1);
for i=1:U
    G{i}=local(T{i},:);
end

figure(1)
plot(G{1}(:,1),G{1}(:,2),'rp');hold on
plot(G{2}(:,1),G{2}(:,2),'bp');hold on
plot(G{3}(:,1),G{3}(:,2),'gp');hold on
% plot(G{4}(:,1),G{4}(:,2),'c*');hold on
% plot(G{5}(:,1),G{5}(:,2),'k*');hold on
% plot(G{6}(:,1),G{6}(:,2),'m*');hold on
% plot(G{7}(:,1),G{7}(:,2),'md');hold on
% plot(G{8}(:,1),G{8}(:,2),'cd');hold on
% plot(G{9}(:,1),G{9}(:,2),'rd');hold on
% plot(G{10}(:,1),G{10}(:,2),'bd');hold on
% plot(G{11}(:,1),G{11}(:,2),'gd');hold on

for i=1:length(A)
    x=local(A(i,1),:);
    y=local(A(i,2),:);
plot([x(1),y(1)],[x(2),y(2)],'k-');hold on
end
set(gca,'Ylim',[0 50]);
set(gca,'Xlim',[0 50]);
