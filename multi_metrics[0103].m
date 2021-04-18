%% 客观指标评价 %%
% %%=========================================================================
% % % 计算图像的边缘强度
% Edge_I = Edge_Intensity(uint8(imgF));
% fprintf('  边缘强度为:%.4f\n ',Edge_I);
% % 计算图像的互信息
% MI = MIabf(imgA,imgB,uint8(imgF));
% fprintf('  互信息为:%.4f\n ',MI);
% % 计算图像的交叉熵
% OCE = OverallCrossEntropy(imgA,imgB,imgF);
% fprintf('  交叉熵为:%.4f\n ',OCE);
% % 计算图像的空间频率
% SF = MySF(uint8(imgF));
% fprintf('  空间频率为:%.4f\n ',SF);
% % 计算图像的标准差
% std = SD(imgF);
% fprintf('  标准差为:%.4f\n ',std);
% % 计算图像的边缘转换率
% Q = Qabf(imgA,imgB,imgF);
% fprintf('  边缘转换率为:%.4f\n ',Q);
% % 计算图像的平均梯度
% AG = AverageGradient(imgF);
% fprintf('  平均梯度为:%.4f\n ',AG);
% % 计算图像的熵
% entroy = MyEntroy(uint8(imgF));
% fprintf('  熵为:%.4f\n ',entroy);