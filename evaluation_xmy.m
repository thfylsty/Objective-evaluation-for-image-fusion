function [ result ] = evaluation_xmy( imgA, imgB, imgF )
%UNTITLED 图像融合评价指标


result(1) = Definition(imgF);                       % 清晰度
result(2) = Edge_Intensity(imgF);                   % 边缘强度EI
result(3) = MySF(imgF);                             % 空间频率SF
result(4) = metricMI(imgA,imgB,double(imgF),1);     % MI互信息
result(5) = metricWang(imgA, imgB, double(imgF));   % NCIE
result(6) = metricPeilla(imgA, imgB, imgF, 1);      % SSIM
result(7) = Qabf(imgA, imgB, imgF); 				% Q^{AB/F}
result(8)=entropy(imgF);%EN熵
% result(9)=metricPWW(imgA, imgB,imgF);%mssim
result(10)=avg_gradient(imgF);%平均梯度
result(11)=variance(imgF);%标准差 均方差mse
result(12)=metricXydeas(imgA, imgB,imgF);%Q_G 梯度
end

