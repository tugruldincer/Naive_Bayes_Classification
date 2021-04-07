%Suleyman_Tugrul_Dincer_2095354
%PART_II
clear all
data=xlsread('UniversalBank.xls',2);
data(:,[1,5])=[];
data(:,2)=abs(data(:,2));
[m,n]=size(data);
for x=[1,2,3,5]
    minData = min(data(:,x));
    maxData = max(data(:,x));
    data(:,x)  = (data(:,x)-minData) / (maxData - minData);  % Scaled to [0, 1]
end
for i=1:m                   %seperate people who have mortgage and do not
    if data(i,7)==0         %have without looking the amount of mortgage
        data(i,7);
    else
        data(i,7)=1;
    end
end
Data=data;error=zeros(81,5);c=1;
for i=2:4
    for j=2:4
        for b=2:4
            for t=2:4
                ik=1/i;jk=1/j;bk=1/b;tk=1/t; %length of each bin
                
                data(:,1)=discretize(data(:,1),0:ik:1); %binning part
                data(:,2)=discretize(data(:,2),0:jk:1);
                data(:,3)=discretize(data(:,3),0:bk:1);
                data(:,5)=discretize(data(:,5),0:tk:1);
                
                rng(3);
                shdata = data(randperm(size(data,1)),:);%partitioning
                valid=shdata(1:(round(m*0.2)),:);
                train=shdata(round(m*0.2)+1:m,:);
                validclass=valid(:,8);
                trainclasss=train(:,8);
                result=naivebayes(train,valid,n);
                
                cm=confusionmat(result,validclass); %construct confusion matrix for comparison
                e=(cm(2,1)+cm(1,2))/size(result,1);
                error(c,1)=i;error(c,2)=j;error(c,3)=b;error(c,4)=t;error(c,5)=e;
                data=Data;c=c+1;
            end
        end
    end
end
[Y,I]=min(error(:,5));