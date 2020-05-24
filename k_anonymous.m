function [cell,bufferpool]=k_anonymous(data,k)

[m,~]=size(data);
global_centroid_time=sum(data(:,1))/m;
global_centroid_x=sum(data(:,2))/m;
global_centroid_y=sum(data(:,3))/m;
L=[global_centroid_time,global_centroid_x,global_centroid_y];

num=0;
while(size(data,1)>=k)
    num=num+1;%the number of group
    [~,I1] = pdist2(data,L,'seuclidean','Largest',1);%找出离全局中心点最远的一个点
    win(1,:)=data(I1,:);
    data(I1,:)=[];
    for j=1:k-1
        centroid_win=centroid(win);
        [~,I2] = pdist2(data,centroid_win,'seuclidean','Smallest',1);
        win(j+1,:)=data(I2,:);
        data(I2,:)=[];
    end
    win_l=centroid(win);
    cell{1,num}=win;%win
    cell{2,num}=win_l;%the centroid of win
    while(size(cell{1,num},1)<2*k-1)
        bre{1,num}=-pdist2(cell{1,num},cell{2,num},'seuclidean');
        [D1,I1] = pdist2(data,cell{2,num},'seuclidean','Smallest',1);
        if -D1>max(bre{1,num})       %自适应阈值可以更改
            cell{1,num}=[cell{1,num};data(I1,:)];%将点加入该簇
            data(I1,:)=[];
            cell{2,num}=centroid(cell{1,num});
            bre{1,num}=[bre{1,num};-D1];
        else
            break;
        end
    end
end

%data里面有剩余数据点
bufferpool=data;
% center_data=[];
% for i=1:num
%     center_data=[center_data;cell{2,i}];
% end
% if(size(data,1)>0)
%     [~,I5] = pdist2(center_data,data(1,:),'seuclidean','Smallest',1);
%     cell{1,I5}=[cell{1,I5};data(1,:)];
%     data(1,:)=[];
%     cell{2,I5}=centroid(cell{1,I5});
% end

end
