function sum_loss=information_loss(k_cluster,l_cluster,data)
data_max_time=max(data(:,1));
data_min_time=min(data(:,1));
data_max_x=max(data(:,2));
data_min_x=min(data(:,2));
data_max_y=max(data(:,3));
data_min_y=min(data(:,3));

sum_k_loss=0;
for i=1:size(k_cluster,2)
    %先标准化
    k_cluster{1,i}(:,2)=(k_cluster{1,i}(:,2)-data_min_x)/(data_max_x-data_min_x);
    k_cluster{1,i}(:,3)=(k_cluster{1,i}(:,3)-data_min_y)/(data_max_y-data_min_y);
    
    k_cluster{2,i}(:,2)=(k_cluster{2,i}(:,2)-data_min_x)/(data_max_x-data_min_x);
    k_cluster{2,i}(:,3)=(k_cluster{2,i}(:,3)-data_min_y)/(data_max_y-data_min_y);
    
    x_loss=abs(k_cluster{1,i}(:,2)-k_cluster{2,i}(1,2));
    y_loss=abs(k_cluster{1,i}(:,3)-k_cluster{2,i}(1,3));
    sum_x_loss=sum(x_loss);
    sum_y_loss=sum(y_loss);
    x_y_loss{1,i}=[sum_x_loss,sum_y_loss];
end
for i=1:size(l_cluster,2)
    l_cluster{1,i}(:,1)=(l_cluster{1,i}(:,1)-data_min_time)/(data_max_time-data_min_time);
    l_cluster{3,i}(:,1)=(l_cluster{3,i}(:,1)-data_min_time)/(data_max_time-data_min_time);

    time_center=l_cluster{1,i}(1,1);
    time_matic=l_cluster{3,i}(:,1);
    time_cha{1,i}=abs(time_matic-time_center);
end
x_y_loss_sum=0;
for i=1:size(x_y_loss,2)
    tmp=sum(x_y_loss{1,i});
    x_y_loss_sum=x_y_loss_sum+tmp;
end
time_loss_sum=0;
for i=1:size(time_cha,2)
    tmp=sum(time_cha{1,i});
    time_loss_sum=time_loss_sum+tmp;
end
sum_loss=x_y_loss_sum+time_loss_sum;



end

