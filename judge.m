function [cluster_2k]=judge(cluster_data,k)   
%���룺cluster_data����2k�ĵ�
% k�����е�ĸ���
%�����cluster_2k{1,:}:���е����ʵʱ������
% cluster_2k{2,:}:������ֵ
[m,~]=size(cluster_data);
global_centroid_time=sum(cluster_data(:,1))/m;
global_centroid_x=sum(cluster_data(:,2))/m;
global_centroid_y=sum(cluster_data(:,3))/m;
L=[global_centroid_time,global_centroid_x,global_centroid_y];

num=0;
while(size(cluster_data,1)>=k)
    num=num+1;%the number of group
    [~,I1] = pdist2(cluster_data,L,'seuclidean','Largest',1);%�ҳ���ȫ�����ĵ���Զ��һ����
    win(1,:)=cluster_data(I1,:);
    cluster_data(I1,:)=[];
    for j=1:k-1
        centroid_win=centroid(win);
        [~,I2] = pdist2(cluster_data,centroid_win,'seuclidean','Smallest',1);
        win(j+1,:)=cluster_data(I2,:);
        cluster_data(I2,:)=[];
    end
    win_l=centroid(win);
    cell{1,num}=win;%win
    cell{2,num}=win_l;%the centroid of win
end

%cluster_data������ʣ�����ݵ�

center_data=[];
for i=1:num
    center_data=[center_data;cell{2,i}];
end
if(size(cluster_data,1)>0)
    [~,I5] = pdist2(center_data,cluster_data(1,:),'seuclidean','Smallest',1);
    cell{1,I5}=[cell{1,I5};cluster_data(1,:)];
    cluster_data(1,:)=[];
    cell{2,I5}=centroid(cell{1,I5});
end

cluster_2k=cell;

    
end
        