addpath('./required_functions');
% 
% load('FITC.mat');
% load('DAPI.mat');
% load('Rh.mat');

layerSkip = 3;
NE = zeros(300, 3);
NEOverlay = zeros(300,3);
NE_Lenght = 0; % Z ����

% ���� �� ���������
for i=1:layerSkip:Zp
%     ��������� ��� �������� � �����
    imgName = [images, 'nucleus_z',num2str(i,'%02d'), 'c1.PNG'];
%     ������ �� �������� �������
    image = imread(imgName);
%     ������� �������� �������� ��������������� �� �������
    imagesc(image);
%     ����� ���������� ������������ �����
    [x,y,P] = impixel();
%     ������� ���������� �����
    numClicks = numel(x);
%     ������ ������� NE ����������� ������������ ������������ ������ �����
%     �������� ������� - ��� ����. Zp ��������� ����������� ����� ��
%     ��������� � ������������ Zp
    NE(NE_Lenght+1:NE_Lenght+numClicks,:) = [x,y,i*7*ones(numClicks,1)];
%     NE ��� �������� �� ����? �� ������� �����
    NEOverlay(NE_Lenght+1:NE_Lenght+numClicks,:) = [x,y,i*ones(numClicks,1)];
%     �������������� ���������� ����� ����
    NE_Lenght = NE_Lenght + numClicks;
end
%     ���������� ��������� ������� MinVolEllipse ��� ������������ ������� A
%     ������� ��������� ������������ �������� � ������� ��������� ������
%     ���� � �� ��������� �������

% ��������� ��� ���������� � N1
N1.NE_points = NE(1:NE_Lenght, :);
N1.NE_overlayPoints = NEOverlay(1:NE_Lenght, :);
% � ������� ����� ����������������� �������
[N1.NE_tensor, N1.NE_center] = MinVolEllipse(N1.NE_points', .001);
[N1.overlayTensor, N1.overlayCenter] = MinVolEllipse(N1.NE_overlayPoints', .001);
% ��� ����� �� �� � �����
[~, D] = eig(N1.NE_tensor);
N1.NE_a = (1/D(1,1))^(1/2);
N1.NE_b = (1/D(2,2))^(1/2);
N1.NE_c = (1/D(3,3))^(1/2);

save('NE.mat', 'N1');

close all;


 