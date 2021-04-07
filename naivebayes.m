function result=naivebayes(a,b,n)
ax=a(:,8);a(:,8)=[];a=[a ax];
bx=b(:,8);b(:,8)=[];b=[b bx];
result=zeros(size(b,1),1);
probzero=sum(a(:,n)==0)/size(a,1);
probone=sum(a(:,n)==1)/size(a,1);
one=zeros(n-1,1);zero=zeros(n-1,1);
for i=1:size(b,1)
    for k=1:n-1
        first  = sum(a(:,k)==b(i,k) & a(:,n)== 1);
        second = sum(a(:,k)==b(i,k) & a(:,n)== 0);
        one(k)= first/sum(a(:,n)==1);
        zero(k)= second/sum(a(:,n)==0);
    end
    first=prod(one)*probone;
    second=prod(zero)*probzero;
    if second>=first
        result(i)=0;
    else
        result(i)=1;
    end
end

