function pri=privacy(k_cluster,l_cluster,data)
%������
% entropy=0;
% for i=1:size(k_cluster,2)
%     length=size(k_cluster{1,i},1);
%     entropy=entropy-(1/length)*log((length-1)/length);
% end
% pri=entropy;
%��Ϣ�� �����Ƿ���
% entropy=0;
% for i=1:size(k_cluster,2)
%     length=size(k_cluster{1,i},1);
%     entropy=entropy+(1/length)*(log(1/length)/log(1/2));
% end
% pri=entropy;
%��Ϣ��
% entropy=0;
% for i=1:size(k_cluster,2)
%     length=size(k_cluster{1,i},1);
%     entropy=entropy-(1/length)*log(1/length);
% end
% pri=entropy;
%�����߹����ɹ��ĸ���
sum_length=0;
for i=1:size(k_cluster,2)
    length=size(k_cluster{1,i},1);
    sum_length=sum_length+1/length;
end
sum_time_length=0;
for i=1:size(l_cluster,2)
    time_length=size(l_cluster{1,i},1);
    sum_time_length=sum_time_length+1/time_length;
end
le=sum_length/size(k_cluster,2);
ll=sum_time_length/size(l_cluster,2);
pri=(1/size(data,1))*le*ll;
end