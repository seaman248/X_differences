layerSkip = 3;
NE = zeros(300, 3);
NEOverlay = zeros(300,3);
NELength = 0;

for i=1:layerSkip:Zp
    imgName = [images, 'nucleus_z',num2str(i,'%02d'), 'c1.PNG'];
    image = imread(imgName);
    imagesc(image);
    [x,y,P] = impixel();
    numClicks = numel(x);
    
    disp([x, y, numClicks]);
end