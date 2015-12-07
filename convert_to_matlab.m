clear all;
basename = 'nucleus11/';
images = ['./nucleus_a/', basename];
[Xp, Yp] = size(rgb2gray(imread(['./nucleus_a/',basename,'/nucleus_z03c3.PNG'])));
fromZ = 1;
toZ = 16;
Zp = toZ - fromZ;

[DAPI, FITC, Rh] = deal(zeros(Xp, Yp, Zp));
chanelIncrementor = 1;
for i = fromZ:1:toZ-1
    filename = [images, 'nucleus_z',num2str(i,'%02d'), 'c3.PNG'];
    DAPIImage = rgb2gray(imread(filename));
    DAPI(:,:,chanelIncrementor) = DAPIImage;
    
    filename = [images, 'nucleus_z',num2str(i, '%02d'), 'c1.PNG'];
    FITCImage = rgb2gray(imread(filename));
    FITC(:,:,chanelIncrementor) = FITCImage;
    
    filename = [images, 'nucleus_z',num2str(i, '%02d'), 'c2.PNG'];
    RhImage = rgb2gray(imread(filename));
    Rh(:,:,chanelIncrementor) = RhImage;

    
    chanelIncrementor = chanelIncrementor + 1;
end

% save('DAPI.mat', 'DAPI');
% save('FITC.mat', 'FITC');
% save('Rh.mat', 'Rh');
% 
% 
% clear; clc;
