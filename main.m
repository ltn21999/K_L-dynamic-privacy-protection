%real dataset
fild=load('smalldataset1.txt');
t1=clock;
data=(fild(:,:));
k=2;
l=3;
[k_cluster,bufferpool]=k_anonymous(data,k);
[l_cluster1]=l_diversity(k_cluster,l);%l_clusters发布
t2=clock;
sum_loss1=information_loss(k_cluster,l_cluster1,data);
pri1=privacy(k_cluster,l_cluster1,data);
 
fild=load('smalldataset2.txt');
t3=clock;
add_data=(fild(:,:));
%increment_center2发送给应用服务器
[increment_clusters2,increment_buffer_x2]=dynamic(k_cluster,bufferpool,add_data,k);
[l_cluster2]=l_diversity(increment_clusters2,l);
t4=clock;
sum_loss2=information_loss(increment_clusters2,l_cluster2,add_data);
Sum_data=[add_data;bufferpool];
C=setdiff(Sum_data,increment_buffer_x2);
pri2=privacy(increment_clusters2,l_cluster2,C);

fild=load('smalldataset3.txt');
t5=clock;
add_data=(fild(:,:));
[increment_clusters3,increment_buffer_x3]=dynamic(increment_clusters2,increment_buffer_x2,add_data,k);
[l_cluster3]=l_diversity(increment_clusters3,l);
t6=clock;
sum_loss3=information_loss(increment_clusters3,l_cluster3,add_data);
Sum_data=[add_data;increment_buffer_x2];
C=setdiff(Sum_data,increment_buffer_x3);
pri3=privacy(increment_clusters3,l_cluster3,C);

fild=load('smalldataset4.txt');
t7=clock;
add_data=(fild(:,:));
[increment_clusters4,increment_buffer_x4]=dynamic(increment_clusters3,increment_buffer_x3,add_data,k);
[l_cluster4]=l_diversity(increment_clusters4,l);
t8=clock;
sum_loss4=information_loss(increment_clusters4,l_cluster4,add_data);
Sum_data=[add_data;increment_buffer_x3];
C=setdiff(Sum_data,increment_buffer_x4);
pri4=privacy(increment_clusters4,l_cluster4,C);

fild=load('smalldataset5.txt');
t9=clock;
add_data=(fild(:,:));
[increment_clusters5,increment_buffer_x5]=dynamic(increment_clusters4,increment_buffer_x4,add_data,k);
[l_cluster5]=l_diversity(increment_clusters5,l);
t10=clock;
sum_loss5=information_loss(increment_clusters5,l_cluster5,add_data);
Sum_data=[add_data;increment_buffer_x4];
C=setdiff(Sum_data,increment_buffer_x5);
pri5=privacy(increment_clusters5,l_cluster5,C);

disp(['1000数据集运行时间:',num2str(etime(t2,t1))]);
disp(['2000数据集运行时间:',num2str(etime(t2,t1)+etime(t4,t3))]);
disp(['3000数据集运行时间:',num2str(etime(t2,t1)+etime(t4,t3)+etime(t6,t5))]);
disp(['4000数据集运行时间:',num2str(etime(t2,t1)+etime(t4,t3)+etime(t6,t5)+etime(t8,t7))]);
disp(['5000数据集运行时间:',num2str(etime(t2,t1)+etime(t4,t3)+etime(t6,t5)+etime(t8,t7)+etime(t10,t9))]);

% [~,n]=size(k_cell);
% A=rand(n,3);%0-1的RGB颜色矩阵
% for i=1:n
%     for j=1:length(k_cell{4,i})
%         x=k_cell{4,i}(j,1);
%         y=k_cell{4,i}(j,2);
%         plot(x,y,'Marker','o','MarkerSize',4,'color',[A(i,1) A(i,2) A(i,3)],'MarkerFace',[A(i,1) A(i,2) A(i,3)]);
%         hold on
%     end
% end

%plot(x,y,'Marker','o','MarkerSize',10,'color',[1 0 0],'MarkerFace',[1,1,0],'LineWidth',2)
%MarkerSize:bian     MarkerFace:填充
