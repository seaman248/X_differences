function [centers] = points_cluster(FP, labels)
centers = zeros(max(labels),3);
for i = 1:1:max(labels) 
ind = find(labels == i);
centers(i,:) = mean(FP(ind,:));
end
end