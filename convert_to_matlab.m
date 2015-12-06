clear all;
images = './nucleus_a/nucleus/';
[Xp, Yp] = size(imread([images, 'nucleus_z01c1.PNG']));
fromZ = 1;
toZ = 44;
Zp = toZ - fromZ;

[DAPI, FITC, Rh] = deal(zeros(Xp, Yp, Zp));

for i = fromZ:toZ
    filename = [images, 'nucleus_z',num2str(i,'%02d'), 'c1.PNG'];
    DAPIImage = imread(filename);
    DAPI(:,:,i) = DAPIImage;
    
    filename = [images, 'nucleus_z',num2str(i, '%02d'), 'c2.PNG'];
    FITCImage = imread(filename);
    FITC(:,:,i) = FITCImage;
    
    filename = [images, 'nucleus_z',num2str(i, '%02d'), 'c3.PNG'];
    RhImage = imread(filename);
    Rh(:,:,i) = RhImage;
end

% save('DAPI.mat', 'DAPI');
% save('FITC.mat', 'FITC');
% save('Rh.mat', 'Rh');
% 
% 
% clear; clc;
