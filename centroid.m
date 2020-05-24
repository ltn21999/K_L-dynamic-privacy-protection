%the centroid of matrix data
function [centroid_data]=centroid(data)
    [m,~]=size(data);
    time=sum(data(:,1))/m;
    x=sum(data(:,2))/m;
    y=sum(data(:,3))/m;
    centroid_data=[time,x,y];
end