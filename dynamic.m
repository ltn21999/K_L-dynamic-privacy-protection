function [increment_clusters,increment_buffer_x]=dynamic(k_cluster,buffer_x,add_data,k)

row=size(k_cluster,2);
sum_data=[buffer_x;add_data];
sum_data_length=size(sum_data,1);
clusters_center=[];
for i=1:row
    clusters_center=[clusters_center;k_cluster{2,i}];
    bre{1,i}=-pdist2(k_cluster{1,i},k_cluster{2,i},'seuclidean');
end

add_cluster_j=[];%��¼�¼���ص��������ݵ�����
for j=1:sum_data_length
    [D1,I1] = pdist2(clusters_center,sum_data(j,:),'seuclidean','Smallest',1);
%     -D1>=mean(bre{1,I1})+max(bre{1,I1})
    if -D1>mean(bre{1,I1})       %����Ӧ��ֵ���Ը���
        k_cluster{1,I1}=[k_cluster{1,I1};sum_data(j,:)];%�������ô�
        add_cluster_j=[add_cluster_j j];%��¼�¼���ص��������ݵ�����
        bre{1,I1}=[bre{1,I1};-D1];
    end
end
%���¼����Ĵؽ���judge�������ж�
break_cluster_2k=[];
break_cluster_2k_i=[];%��¼�²�����2k������
for i=1:row
    if size(k_cluster{1,i},1)>=2*k
        [cluster_2k]=judge(k_cluster{1,i},k);
        break_cluster_2k=[break_cluster_2k cluster_2k];
    else
        break_cluster_2k_i=[break_cluster_2k_i i];
    end
end


sum_data(add_cluster_j,:)=[];
increment_buffer_x=sum_data;

increment_clusters=[break_cluster_2k k_cluster(1:2,break_cluster_2k_i)];

end







