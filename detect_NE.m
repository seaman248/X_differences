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
    NE(NE_Lenght+1:NE_Lenght+numClicks,:) = [x,y,i*7*ones(numClicks,1)];
%     �������������� ���������� ����� ����
    NE_Lenght = NE_Lenght + numClicks;
end

 