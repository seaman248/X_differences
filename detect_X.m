layerSkip = 2;
load('NE.mat');

S1 = zeros(300, 3);
S1_length = 0;

rgbLayer = zeros(Xp, Yp, 3);

for i=1:layerSkip:Zp
    rgbLayer(:,:,3) = DAPI(:,:,i)/max(max(DAPI(:,:,i)));
    rgbLayer(:,:,1) = Rh(:,:,i)/max(max(Rh(:,:,i)));
    imagesc(rgbLayer);
    [x,y,P] = impixel();
    numClicks = numel(x);
    z = i*7*ones(numClicks,1);
    zOverlay = i*ones(numClicks, 1);
    S1(S1_length+1:S1_length+numClicks, :) = [x, y, z];
    S1_overlay(S1_length+1:S1_length+numClicks, :) = [x, y, zOverlay];
    S1_length = S1_length + numClicks;
end
close all;
% Кластеризация
[labels, type] = dbscan(S1(1:S1_length, :), 1, 1);
all_clusters = points_cluster(S1, labels);

N1.L2_signals = S1;

num_clusters = 1;
S1_auto_clusters = [];
S1_over_clusters = [];
for i = 1:1:S1_length
    x = S1(i,:);
    if ( (x-N1.NE_center')*N1.NE_tensor*(x'-N1.NE_center) <= 1 ) %inside NE
        S1_auto_clusters(num_clusters,:) = x;
        S1_over_clusters(num_clusters,:) = S1_overlay(i,:);
        num_clusters = num_clusters + 1;
    end
end
N1.L2_clusters = S1_auto_clusters;
S1_auto_clusters = S1(1:S1_length,:);
num_clusters = S1_length;
[A , C] = MinVolEllipse(S1_auto_clusters', .001);
N1.L2_tensor = A;
N1.L2_center = C;
[~,D] = eig(A);
N1.L2_a = (1/D(1,1))^(1/2);
N1.L2_b = (1/D(2,2))^(1/2);
N1.L2_c = (1/D(3,3))^(1/2);
[A , C] = MinVolEllipse(S1_over_clusters', .001);
N1.L2_overlay_tensor = A;
N1.L2_overlay_center = C;
save('NE.mat','N1');
