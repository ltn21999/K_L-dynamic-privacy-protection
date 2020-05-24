function [centroid_time]=centroid_l(data)
    m=size(data,1);
    centroid_time=sum(data(:,1))/m;
end