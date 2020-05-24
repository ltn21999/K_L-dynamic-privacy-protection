function [l_cluster]=l_diversity(k_cluster,l)

time_metic=[];x_y_metic=[];intex_time=[];
for i=1:size(k_cluster,2)
    time_metic=[time_metic;k_cluster{2,i}(1,1)];
    x_y_metic=[x_y_metic;k_cluster{2,i}(1,2:3)];
    intex_time=[intex_time;i];
end
time_metic=[time_metic intex_time];

m=size(time_metic,1);
global_centroid_time=sum(time_metic(:,1))/m;
L=global_centroid_time;

num=0;
while(size(time_metic,1)>=l)
    num=num+1;%the number of group
    [~,I1] = pdist2(time_metic(:,1),L,'euclidean','Largest',1);%找出离全局中心点最远的一个点
    %cell{3,num}存储时间列的下坐标
    cell{3,num}=[];
    cell{3,num}=[cell{3,num},time_metic(I1,2)];
    
    win(1,1)=time_metic(I1,1);
    time_metic(I1,:)=[];
    for j=1:l-1
        centroid_win=centroid_l(win);
        [~,I2] = pdist2(time_metic(:,1),centroid_win,'euclidean','Smallest',1);
        cell{3,num}=[cell{3,num},time_metic(I2,2)];
        win(j+1,1)=time_metic(I2,1);
        time_metic(I2,:)=[];
    end
    win_l=centroid_l(win);
    cell{1,num}=win;%win
    cell{2,num}=win_l;%the centroid of win
end
for i=1:num
    cell{4,i}=[];Sum=[];
    for j=1:size(cell{3,i},2)
        intex_x_y=cell{3,i}(1,j);
        x_y=k_cluster{1,intex_x_y};
        Sum=[Sum;x_y];  
    end
    cell{4,i}=Sum;
end
%cluster_data里面有剩余数据点

center_data=[];
for i=1:num
    center_data=[center_data;cell{2,i}];
end
if(size(time_metic,1)>0)
    [~,I5] = pdist2(center_data,time_metic(1,1),'euclidean','Smallest',1);
    cell{1,I5}=[cell{1,I5};time_metic(1,1)];
    cell{3,I5}=[cell{3,I5},time_metic(1,2)];
    time_metic(1,:)=[];
    cell{2,I5}=centroid_l(cell{1,I5});
end
% l_clusters=cell;
for i=1:num
    for j=1:length(cell{3,i})
        l_cluster{1,i}(j,1)=cell{2,i};
        l_cluster{1,i}(j,2:3)=x_y_metic(cell{3,i}(1,j),:);
        l_cluster{2,i}=cell{3,i};
    end
end
for i=1:num
    l_cluster{3,i}=cell{4,i};
end

end