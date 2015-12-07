load('NE.mat');
addpath('./freezeColors/');
addpath('./EllipsePrj/');
% convert_to_matlab;
% detect_NE;
% detect_X;
A = N1.NE_tensor;
C = N1.NE_center;

freezeColors
S1_clusters = N1.L2_clusters;
for i = 1:1:size(S1_clusters,1)
    S1_clusters(i,:) = S1_clusters(i,:) - C';
end

plot3(S1_clusters(:,1)+C(1),S1_clusters(:,2)+C(2),S1_clusters(:,3)+C(3),'.r','markersize',25);

S1_NE_distances = zeros(numel(S1_clusters,1),1);
N1.NE_L2_lines  = zeros(numel(S1_clusters,1),6);
[radii U] = EllAlg2Geo(A, 0, -1);
for i=1:1:size(S1_clusters,1);
hold on
x = EllPrj(S1_clusters(i,:)', radii, U, 0, true);
l = sqrt(sum(bsxfun(@minus, x, S1_clusters(i,:)').^2, 1));
[lmin imin] = min(l);
S1_NE_distances(i) = lmin;
hold on
    for k=1:size(x,2)
        if k==imin
            linespec = '-r.';
            plot3([x(1,k)+C(1) S1_clusters(i,1)+C(1)],[x(2,k)+C(2) S1_clusters(i,2)+C(2)],[x(3,k)+C(3) S1_clusters(i,3)+C(3)],linespec,'linewidth',2);
            N1.NE_L2_lines(i,:) = [x(1,k)+C(1) S1_clusters(i,1)+C(1) x(2,k)+C(2) S1_clusters(i,2)+C(2) x(3,k)+C(3) S1_clusters(i,3)+C(3)];
        else
            linespec = '-c.';
        end
    end
end
N1.L2_NE_distances = S1_NE_distances;
N1.L2_NE_contacts  = sum(S1_NE_distances < 20);
N1.L2_name = '2L';
save('nucleus.mat','N1');

hold on
Ellipse_plot(A,C,{20},6);
hold on
xlim([-50 350])
ylim([-50 350])
zlim([-50 350])
axis off
set(gca,'XLimMode','manual');
set(gca,'YLimMode','manual');
set(gca,'ZLimMode','manual');