addpath('./required_functions');
% 
% load('FITC.mat');
% load('DAPI.mat');
% load('Rh.mat');

layerSkip = 3;
NE = zeros(300, 3);
NEOverlay = zeros(300,3);
NE_Lenght = 0; % Z ядра

% Цикл по картинкам
for i=1:layerSkip:Zp
%     Формируем имя картинки в цикле
    imgName = [images, 'nucleus_z',num2str(i,'%02d'), 'c1.PNG'];
%     Делаем из картинки матрицу
    image = imread(imgName);
%     Выводим картинку обратным преобразованием из матрицы
    imagesc(image);
%     Берем координаты поставленных точек
    [x,y,P] = impixel();
%     Считаем количество точек
    numClicks = numel(x);
%     Строки матрицы NE заполняются координатами поставленных мышкой точек
%     Возможно семерка - это коэф. Zp поскольку размерность слоев не
%     совпадает с размерностью Zp
    NE(NE_Lenght+1:NE_Lenght+numClicks,:) = [x,y,i*7*ones(numClicks,1)];
%     NE без поправки на слои? не понятно зачем
    NEOverlay(NE_Lenght+1:NE_Lenght+numClicks,:) = [x,y,i*ones(numClicks,1)];
%     Инкрементируем переменную длины ядра
    NE_Lenght = NE_Lenght + numClicks;
end
%     Используем стороннюю функцию MinVolEllipse для формирования тензора A
%     который описывает расположение оболочки и расчета координат центра
%     ядра С по алгоритму Кахияна

% Сохраняем все результаты в N1
N1.NE_points = NE(1:NE_Lenght, :);
N1.NE_overlayPoints = NEOverlay(1:NE_Lenght, :);
% В функцию берем транспонированную матрицу
[N1.NE_tensor, N1.NE_center] = MinVolEllipse(N1.NE_points', .001);
[N1.overlayTensor, N1.overlayCenter] = MinVolEllipse(N1.NE_overlayPoints', .001);
% Хер пойми че эт и зачем
[~, D] = eig(N1.NE_tensor);
N1.NE_a = (1/D(1,1))^(1/2);
N1.NE_b = (1/D(2,2))^(1/2);
N1.NE_c = (1/D(3,3))^(1/2);

save('NE.mat', 'N1');

close all;


 