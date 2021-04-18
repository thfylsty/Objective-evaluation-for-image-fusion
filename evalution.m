function [evals] = evalution(imgA, imgB, imgF)
%% 采用多种评价指标对融合效果进行评估
evals(1) = Edge_Intensity(imgF); % 边缘强度 EI
evals(2) = OverallCrossEntropy(imgA, imgB, imgF); % 总体平均交叉熵
evals(3) = MySF(imgF);    % 空间频率【x,y】 SF2
evals(4) = entropy(imgF); % EN
evals(5) = analysis_Qabf(imgA,imgB,imgF); %Qabf
evals(6) = analysis_SCD(imgA,imgB,imgF); %SCD
evals(7) = analysis_fmi(imgA,imgB,imgF,'wavelet');%FMI_w
evals(8) = analysis_fmi(imgA,imgB,imgF,'dct');%FMI_dct
evals(9) = analysis_ssim(imgA,imgB,imgF); %ssim
evals(10) = analysis_MSSSIM(imgA,imgB,imgF); %MSSSIM
evals(11) = analysis_fmi(imgA,imgB,imgF);%FMI_pixel
evals(12) = analysis_nabf(imgF,imgA,imgB); %Nabf
evals(13) = analysis_MI(imgA,imgB,imgF);%MI
evals(14)  = (vifvec(im2double(imgA),im2double(imgF))+vifvec(im2double(imgB),im2double(imgF)))/2;%vif


evals(15) = std2(imgF);       % SD
evals(16) = evals(4);    % 熵 EN
evals(17) = Definition(imgF); % 清晰度 DF
evals(18) = metricZheng(imgA, imgB,imgF); % QSF

evals(19) = metricMI(imgA,imgB,imgF,1);   % QMI
evals(20) = metricPeilla(imgA, imgB, imgF, 1);      % QS
evals(21)= metricYang(imgA, imgB, imgF);      % QY
evals(22) = metricCvejic(imgA, imgB, imgF,2);      % QC
evals(23) = metricWang(imgA, imgB, double(imgF));  % QNCIE
evals(24) = Qabf(imgA, imgB, imgF); 				% Q^{AB/F}
evals(25) = avg_gradient(imgF);    %平均梯度 AG

evals(26) = MIabf(imgA, imgB, uint8(imgF)); % MI2
evals(27) = metricXydeas(imgA, imgB, imgF);      % QG
evals(28) = my_cc(imgA, imgB, imgF);     % CC
evals(29) = VIFF_Public(imgA, imgB, imgF);  %VIFF

evals(30) = metricZhao(imgA, imgB, imgF);      % QP
evals(31) = metricPeilla(imgA, imgB, imgF, 2);      % QW
evals(32) = metricPeilla(imgA, imgB, imgF, 3);      % QE
evals(33) = metricChen(imgA, imgB, imgF);      % QCV
evals(34) = metricChenBlum(imgA, imgB, imgF);      % QCB







end
