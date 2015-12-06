layerSkip = 2;
load('NE.mat');

S1 = zeros(300, 3);
S1_lenght = 0;

rgbLayer = zeros(Xp, Yp, 3);

for i=1:layerSkip:Zp
    rgbLayer(:,:,3) = DAPI(:,:,i)/max(max(DAPI(:,:,i)));
    rgbLayer(:,:,2) = FITC(:,:,i)/max(max(FITC(:,:,i)));
    imagesc(rgbLayer);
    [x,y,P] = impixel();
    numClicks = numel(x);
    z = i*7*ones(numClicks,1);
    zOverlay = i*ones(numClicks, 1);
    S1(S1_lenght+1:S1_lenght+numClicks, :) = [x, y, z];
    S1_overlay(S1_lenght+1:S1_lenght+numClicks, :) = [x, y, zOverlay];
    S1_lenght = S1_lenght + numClicks;
end
close all;
% Не понятно зачем эти 2 строки
[labels, type] = dbscan(S1(1:S1_lenght, :), 1, 1);
all_clusters = points_cluster(S1, labels);

N1.L2_signals = S1;

