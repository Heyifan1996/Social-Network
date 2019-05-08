function [ result] = condition( temp1,temp2,unode,Neigh)
    N=[];
    n=[];
if ~isempty(unode)
    for i=1:length(unode)
        if length(Neigh{unode(i)})>=2 && length(Neigh{unode(i)})<=3
            N=[N,unode(i)];
            n=[n,length(Neigh{unode(i)})];
        else
            continue
        end
    end
end
    temp=ceil((length(unode)-length(N))/2)+1+0.5*sum(2-(4-n));
if temp>0.5*max(length(temp1),length(temp2))
    result=true;
else
    result=false;
end

